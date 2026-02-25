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
    
    private init() {}
    
    public func show(_ toast: ToastNotification) {
        dismissTask?.cancel()
        
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
        
        dismissTask = Task {
            try? await Task.sleep(for: .seconds(toast.duration))
            guard !Task.isCancelled else { return }
            self.isPresented = false
        }
    }
}
