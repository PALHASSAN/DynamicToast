//
//  ViewDynamicToast.swift
//  DynamicToast
//
//  Created by Alhassan AlMakki on 08/09/1447 AH.
//

import SwiftUI

public extension View {
    func withDynamicToastContainer() -> some View {
        self.modifier(DynamicIslandToastContainerModifier())
    }
}

@MainActor
private struct DynamicIslandToastContainerModifier: ViewModifier {
    @State private var overlayWindow: PassThroughWindow?
    @State private var overlayController: CustomHostingView<ToastView>?
    private var manager = ToastManager.shared
    
    func body(content: Content) -> some View {
        content
            .background(WindowExtractor { mainWindow in
                createOverlayWindow(mainWindow)
            })
            .onChange(of: manager.isPresented) { _, newValue in
                overlayController?.isStatusBarHidden = newValue
            }
    }
    
    private func createOverlayWindow(_ mainWindow: UIWindow) {
        guard let windowScene = mainWindow.windowScene else { return }
        
        if let window = windowScene.windows.first(where: { $0.tag == 1009 }) as? PassThroughWindow {
            self.overlayWindow = window
        } else {
            let overlayWindow = PassThroughWindow(windowScene: windowScene)
            overlayWindow.backgroundColor = .clear
            overlayWindow.isHidden = false
            overlayWindow.isUserInteractionEnabled = true
            overlayWindow.tag = 1009
            
            let hostingController = CustomHostingView(rootView: ToastView())
            hostingController.view.backgroundColor = .clear
            overlayWindow.rootViewController = hostingController
            
            self.overlayController = hostingController
            self.overlayWindow = overlayWindow
        }
    }
}
