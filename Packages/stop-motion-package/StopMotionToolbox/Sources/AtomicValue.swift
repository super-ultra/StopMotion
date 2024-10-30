import os

/// Thread safe atomic wrapper for Sendable value.
/// Supports 
public final class AtomicValue<Value: Sendable>: @unchecked Sendable {

    public init(_ initialValue: Value) {
        self._value = initialValue
    }

    /// _read + _modify работают за один такт и вызовы `lock` в таком случае консистентны.
    /// set работает вроде такого:
    /// ```
    /// let newValue = <some value>
    /// _value = newValue
    /// ```
    /// и если `<some value>` зависит от `get`, например, `atomic.value += 1`
    /// То вызовы
    /// ```
    /// let newValue = _value + 1
    /// _value = newValue
    /// ```
    ///  будут в разных критических регионах.
    public var value: Value {
        _read {
            lock.lock()
            defer { lock.unlock() }
            yield _value
        } _modify {
            lock.lock()
            defer { lock.unlock() }
            yield &_value
        }
    }

    private var _value: Value
    private let lock = OSAllocatedUnfairLock()
}
