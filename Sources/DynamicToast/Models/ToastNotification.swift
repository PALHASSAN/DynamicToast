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
    var icon: ToastIcon?
    var iconColor: Color = .white
    var iconSize: CGFloat = 32
    var duration: TimeInterval = 3.0
    
    public private(set) var title: String = ""
    public private(set) var body: String = ""
    public private(set) var titleFont: Font = .callout
    public private(set) var bodyFont: Font = .caption
    
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
    
    // MARK: - Phosphors Icon
    public func icon(_ image: Image) -> Self {
        var copy = self
        copy.icon = .custom(image)
        return copy
    }
    
    public func systemIcon(_ name: String) -> Self {
        var copy = self
        copy.icon = .system(name)
        return copy
    }
    
    public func iconColor(_ color: Color) -> Self {
        var copy = self
        copy.iconColor = color
        return copy
    }
    
    public func iconSize(_ size: CGFloat) -> Self {
        var copy = self
        copy.iconSize = size
        return copy
    }
    
    public func success() -> Self {
        var copy = self
        copy.icon = .system("checkmark.seal.fill")
        copy.iconColor = .twEmerald400
        return copy
    }
    
    public func error() -> Self {
            var copy = self
            copy.icon = .system("xmark.octagon.fill")
            copy.iconColor = .twRed400
            return copy
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

public extension ToastNotification {
    @MainActor
    func sendToNativeDynamicIsland() {
        // Extract system icon name if it's a system icon
        var sysIcon: String? = nil
        if case .system(let name) = self.icon {
            sysIcon = name
        }
        
        // Start the Activity
        LiveActivityManager.shared.start(
            title: self.title,
            body: self.body,
            systemIcon: sysIcon
        )
        
        // Auto-dismiss after the duration
        Task {
            try? await Task.sleep(for: .seconds(self.duration))
            LiveActivityManager.shared.end(dismissalPolicy: .immediate)
        }
    }
}
