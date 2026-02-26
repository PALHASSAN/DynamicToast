//
//  PassThroughWindow.swift
//  DynamicToast
//
//  Created by Alhassan AlMakki on 08/09/1447 AH.
//

import SwiftUI

@Observable
class PassThroughWindow: UIWindow {
    var toast: ToastNotification? = nil
    var isPresented: Bool = false
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event),
              let rootView = rootViewController?.view else {
            return nil
        }
        if #available(iOS 26, *) {
            if rootView.layer.hitTest(point)?.name == nil {
                return rootView
            }
            
            return nil
        } else {
            if #unavailable(iOS 18) {
                return hitView == rootView ? nil : hitView
            } else {
                for subView in rootView.subviews.reversed() {
                    let pointInSubView = subView.convert(point, from: rootView)
                    if subView.hitTest(pointInSubView, with: event) != nil {
                        return subView
                    }
                }
                
                return nil
            }
        }
    }
}
