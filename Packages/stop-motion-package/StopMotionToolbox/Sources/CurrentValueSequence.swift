import Foundation
import os

/// CurrentValue AsyncSequence
///
///  Producer:
///    ```
///       public final class Service: Sendable {
///          public var sequence: CurrentValueSequence<Int> {
///              get async { await subject.makeSequence() }
///          }
///
///          private let subject = CurrentValueSequenceSubject<Int>(0)
///
///          private func produceElement() {
///              Task { @MainActor in await subject.send(1) }
///          }
///       }
///    ```
///
///  Consumer:
///   ```
///       let sequence = await service.sequence
///       let value = sequence.currentValueSync        // freezing thread
///       let asyncValue = await sequence.currentValue // not freezing thread
///
///       for await newValue in sequence {
///           print("new value \(newValue)")
///       }
///   ```
public struct CurrentValueSequence<Element: Sendable>: AsyncSequence, Sendable {

    public typealias AsyncIterator = AsyncStream<Element>.Iterator

    public var currentValue: Element {
        get {
            subject.currentValue()
        }
    }

    public func makeAsyncIterator() -> AsyncIterator {
        stream.makeAsyncIterator()
    }

    // MARK: - Fileprivate

    fileprivate init(
        subject: CurrentValueSequenceSubject<Element>,
        stream: AsyncStream<Element>
    ) {
        self.subject = subject
        self.stream = stream
    }

    // MARK: - Private

    private let subject: CurrentValueSequenceSubject<Element>
    private let stream: AsyncStream<Element>
}

public final class CurrentValueSequenceSubject<Element: Sendable>: @unchecked Sendable {

    public init(_ initialValue: Element) {
        self.value = initialValue
    }

    public func send(_ value: Element) {
        _send(value)
    }

    public func finish() {
        _finish()
    }

    public func currentValue() -> Element {
        return _currentValue()
    }

    // MARK: - Private
    
    private func _currentValue() -> Element {
        return lock.withLock { value }
    }
    
    private func _send(_ value: Element) {
        lock.lock()
        defer { lock.unlock() }
        
        guard !isFinished else { return }
        
        self.value = value
        
        continuations.forEach {
            let result = $0.1.yield(value)
            if case .terminated = result {
                continuations.removeValue(forKey: $0.0)
            }
        }
    }
    
    private func _finish() {
        let continuationsToFinish = lock.withLock {
            isFinished = true
            
            let continuations = self.continuations
            self.continuations.removeAll()
            return continuations
        }
        
        continuationsToFinish.forEach {
            $0.1.finish()
        }
    }

    private func _appendContinuation(
        _ uuid: UUID,
        continuation: AsyncStream<Element>.Continuation,
        skipFirstValue: Bool
    ) {
        lock.lock()
        defer { lock.unlock() }
        
        if !skipFirstValue {
            continuation.yield(value)
        }
        if isFinished {
            continuation.finish()
        } else {
            continuations[uuid] = continuation
        }
    }

    private func _resetForIterator(_ uuid: UUID) {
        lock.lock()
        defer { lock.unlock() }
        
        continuations[uuid] = nil
    }
    
    private var value: Element
    private var continuations: [UUID: AsyncStream<Element>.Continuation] = [:]
    private var isFinished: Bool = false
    private let lock = OSAllocatedUnfairLock()
}

extension CurrentValueSequenceSubject {

    /// Async constructor for CurrentValueSequence.
    /// Waits for the actual subscription to avoid skipping any values.
    ///
    ///  - Parameters:
    ///    - subject: `CurrentValueSequenceSubject` that produces elements.
    ///    - skipFirstValue: `true` when initial value is not needed. Subscribe only for updates.
    ///    - bufferringAllValues: `true` when you need all the history of updates.
    ///    Prevents skipping intermediate updates on slow consumers. May reduce performance.
    public func makeSequence(
        skipFirstValue: Bool = false,
        bufferringAllValues: Bool = false
    ) -> CurrentValueSequence<Element> {
        let updates = AsyncStream<Element>.makeStream(
            bufferingPolicy: bufferringAllValues ? .unbounded : .bufferingNewest(1)
        )

        let uuid = UUID()
        _appendContinuation(
            uuid,
            continuation: updates.continuation,
            skipFirstValue: skipFirstValue
        )
        updates.continuation.onTermination = { [weak self] _ in
            self?._resetForIterator(uuid)
        }

        return CurrentValueSequence(subject: self, stream: updates.stream)
    }

    /// Sync constructor for CurrentValueSequence.
    /// May skip some values, but the last value has to be sent.
    ///
    ///  - Parameters:
    ///    - subject: `CurrentValueSequenceSubject` that produces elements.
    ///    - skipFirstValue: `true` when initial value is not needed. Subscribe only for updates.
    ///    - bufferringAllValues: `true` when you need all the history of updates.
    ///    Prevents skipping intermediate updates on slow consumers. May reduce performance.
    public nonisolated func makeSequenceSync(
        skipFirstValue: Bool = false,
        bufferringAllValues: Bool = false
    ) -> CurrentValueSequence<Element> {
        let updates = AsyncStream<Element>.makeStream(
            bufferingPolicy: bufferringAllValues ? .unbounded : .bufferingNewest(1)
        )

        Task { [weak self] in
            guard let self else { return }
            let uuid = UUID()
            _appendContinuation(
                uuid,
                continuation: updates.continuation,
                skipFirstValue: skipFirstValue
            )
            updates.continuation.onTermination = { [weak self] _ in
                self?._resetForIterator(uuid)
            }
        }

        return CurrentValueSequence(subject: self, stream: updates.stream)
    }

}

extension CurrentValueSequence {
    public static func constant(_ value: Element) -> CurrentValueSequence<Element> {
        let subject = CurrentValueSequenceSubject(value)
        return subject.makeSequenceSync()
    }
}
