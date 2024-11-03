//
//  ZoomView.swift
//  stop-motion-package
//
//  Created by Ilya Lobanov on 03.11.2024.
//

import SwiftUI


public struct ZoomView<Content: View>: UIViewRepresentable {
    
    public init(minZoom: CGFloat, maxZoom: CGFloat, bounces: Bool = true, onGesture: (() -> Void)? = nil, @ViewBuilder content: () -> Content) {
        self.minZoom = minZoom
        self.maxZoom = maxZoom
        self.bounces = bounces
        self.onGesture = onGesture
        self.content = content()
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
        scrollView.maximumZoomScale = maxZoom
        scrollView.minimumZoomScale = minZoom
        scrollView.bouncesZoom = bounces
        scrollView.bounces = bounces
        
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        scrollView.addSubview(hostedView)
        
        return scrollView
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: content), onGesture: onGesture)
    }
    
    public func updateUIView(_ uiView: UIScrollView, context: Context) {
        context.coordinator.hostingController.rootView = content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    // MARK: - Coordinator
    
    public final class Coordinator: NSObject, UIScrollViewDelegate {
        fileprivate let hostingController: UIHostingController<Content>
        fileprivate let onGesture: (() -> Void)?
        
        fileprivate init(hostingController: UIHostingController<Content>, onGesture: (() -> Void)?) {
            self.hostingController = hostingController
            self.onGesture = onGesture
        }
        
        // MARK: - UIScrollViewDelegate
        
        public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
        
        public func scrollViewDidZoom(_ scrollView: UIScrollView) {
            onGesture?()
        }
    }
    
    // MARK: - Private
    
    private let content: Content
    private let minZoom: CGFloat
    private let maxZoom: CGFloat
    private let bounces: Bool
    private let onGesture: (() -> Void)?
}
