//
//  CustomHostingView.swift
//  DynamicToast
//
//  Created by Alhassan AlMakki on 08/09/1447 AH.
//

import SwiftUI

@MainActor
public final class CustomHostingView<Content: View>: UIHostingController<Content> {
    public var isStatusBarHidden: Bool = false {
        didSet { setNeedsStatusBarAppearanceUpdate() }
    }
    
    public override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
}
