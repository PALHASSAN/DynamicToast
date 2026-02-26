//
//  ToastManager.swift
//  DynamicToast
//
//  Created by Alhassan AlMakki on 08/09/1447 AH.
//

import SwiftUI

@MainActor
@Observable
public final class ToastManager {
    public static let shared = ToastManager()
    
    public var currentToast: ToastNotification? = nil
    public var isPresented: Bool = false
    private var dismissTask: Task<Void, Never>?
    
    private var overlayWindow: PassThroughWindow?
    
    private init() {}
    
    public func show(_ toast: ToastNotification) {
        dismissTask?.cancel()
        
        // We do not need to call the Modifier
        setupWindowIfNeeded()
        
        if isPresented {
            isPresented = false
            // Brief delay to allow dismiss animation before presenting the new one
            Task {
                try? await Task.sleep(for: .milliseconds(100))
                self.presentNew(toast)
            }
        } else {
            presentNew(toast)
        }
    }
    
    private func presentNew(_ toast: ToastNotification) {
        currentToast = toast
        isPresented = true
        
        withAnimation(.bouncy(duration: 0.3, extraBounce: 0)) {
            isPresented = true
        }
        
        dismissTask = Task {
            try? await Task.sleep(for: .seconds(toast.duration))
            guard !Task.isCancelled else { return }
            
            withAnimation(.bouncy(duration: 0.3, extraBounce: 0)) {
                self.isPresented = false
            }
            
            self.isPresented = false
        }
    }
    private func setupWindowIfNeeded() {
        guard overlayWindow == nil else { return }
        
        guard let windowScene = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .compactMap({ $0 as? UIWindowScene })
            .first else { return }
        
        let window = PassThroughWindow(windowScene: windowScene)
        window.backgroundColor = .clear
        window.isHidden = false
        window.isUserInteractionEnabled = true
        window.tag = 1009
        
        let hostingController = CustomHostingView(rootView: ToastView())
        hostingController.view.backgroundColor = .clear
        window.rootViewController = hostingController
        
        self.overlayWindow = window
    }
}
