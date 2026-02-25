//
//  ToastNotification.swift
//  DynamicToast
//
//  Created by Alhassan AlMakki on 08/09/1447 AH.
//

import SwiftUI
import PhosphorSwift

public struct ToastNotification: Identifiable, Sendable {
    public private(set) var id: String = UUID().uuidString
    
    public var title: String = ""
    public var body: String = ""
    public var icon: ToastIcon?
    public var iconColor: (Color, Color) = (.white, .green)
    public var duration: TimeInterval = 3.0
    
    public var titleFont: Font = .callout
    public var bodyFont: Font = .caption
    
    var isArabic: Bool {
        let combinedText = title + body
        return combinedText.range(of: "\\p{Arabic}", options: .regularExpression) != nil
    }
    
    private init() {}
    
    public static func make() -> ToastNotification {
        return ToastNotification()
    }
    
    public func title(_ title: String, font: Font? = nil) -> Self {
        var copy = self
        copy.title = title
        if let font { copy.titleFont = font }
        return copy
    }
    
    public func body(_ body: String, font: Font? = nil) -> Self {
        var copy = self
        copy.body = body
        if let font { copy.bodyFont = font }
        return copy
    }
    
    public func icon(_ icon: ToastIcon, color: Color = .white, secondaryColor: Color = .white) -> Self {
        var copy = self
        copy.icon = icon
        copy.iconColor = (secondaryColor, color)
        return copy
    }
    
    public func success() -> Self {
        return self.icon(.system("checkmark.seal.fill"), color: .twEmerald400)
    }
    
    public func error() -> Self {
        return self.icon(.system("xmark.octagon.fill"), color: .twRed400)
    }
    
    public func duration(_ duration: TimeInterval) -> Self {
        var copy = self
        copy.duration = duration
        
        return copy
    }
    
    @MainActor
    public func send() {
        ToastManager.shared.show(self)
    }
}
