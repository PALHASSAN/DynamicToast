//
//  ToastIcon.swift
//  DynamicToast
//
//  Created by Alhassan AlMakki on 08/09/1447 AH.
//

import SwiftUI
@preconcurrency import PhosphorSwift

public enum ToastIcon: Sendable {
    case system(String)
    case custom(Image)
}
