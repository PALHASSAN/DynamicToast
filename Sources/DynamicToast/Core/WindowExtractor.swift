//
//  WindowExtractor.swift
//  DynamicToast
//
//  Created by Alhassan AlMakki on 08/09/1447 AH.
//

import SwiftUI

@MainActor
public struct WindowExtractor: UIViewRepresentable {
    public var result: @MainActor (UIWindow) -> Void
    
    public init(result: @escaping @MainActor (UIWindow) -> Void) {
        self.result = result
    }
    
    public func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        Task { @MainActor in
            if let window = view.window {
                self.result(window)
            }
        }
        
        return view
    }
    
    public func updateUIView(_ uiView: UIView, context: Context) {}
}
