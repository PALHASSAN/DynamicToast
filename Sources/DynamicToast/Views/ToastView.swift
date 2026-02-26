//
//  ToastView.swift
//  DynamicToast
//
//  Created by Alhassan AlMakki on 08/09/1447 AH.
//

import SwiftUI
import PhosphorSwift

struct ToastTextHeightKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

@MainActor
public struct ToastView: View {
    private var manager = ToastManager.shared
    
    // Save text height
    @State private var textHeight: CGFloat = 0
    
    public init() {}
    
    public var body: some View {
        GeometryReader { proxy in
            let safeArea = proxy.safeAreaInsets
            let size = proxy.size
            
            // DynamicIsland
            let haveDynamicIsland: Bool = safeArea.top >= 59
            let dynamicIslandWidth: CGFloat = 120
            let dynamicIslandHeight: CGFloat = 36
            let topOffest: CGFloat = 11 + max((safeArea.top - 59), 0)
            
            // Expanded
            let isExpended = manager.isPresented
            let iconSize = manager.currentToast?.iconSize ?? 32
            let verticalPadding: CGFloat = haveDynamicIsland ? 55 : 30
            let defaultHeight: CGFloat = haveDynamicIsland ? 90 : 70
            
            let expendedWidth = size.width - 20
            
            let textMargin: CGFloat = haveDynamicIsland ? 50 : 30
            let textBasedHeight = textHeight > 0 ? (textHeight + textMargin) : defaultHeight
            let expendedHeight: CGFloat = max(defaultHeight, iconSize + verticalPadding, textBasedHeight)
            
            let scaleX: CGFloat = isExpended ? 1 : (dynamicIslandWidth / expendedWidth)
            let scaleY: CGFloat = isExpended ? 1 : (dynamicIslandHeight / expendedHeight)
            
            ZStack {
                if #available(iOS 26.0, *) {
                    ConcentricRectangle(
                        corners: .concentric(minimum: .fixed(30)), isUniform: true
                    )
                    .fill(.black)
                    .overlay {
                        ToastContent(haveDynamicIsland, isExpended: isExpended)
                            .frame(width: expendedWidth, height: expendedHeight)
                            .scaleEffect(x: scaleX, y: scaleY)
                    }
                    .frame(
                        width: isExpended ? expendedWidth : dynamicIslandWidth,
                        height: isExpended ? expendedHeight : dynamicIslandHeight
                    )
                    .offset(
                        y: haveDynamicIsland ? topOffest : (isExpended ? safeArea.top + 10 : -80)
                    )
                    // Devices that do not have dynamic island
                    .opacity(haveDynamicIsland ? 1 : (isExpended ? 1 : 0))
                    // Devices that have dynamic island
                    .animation(.linear(duration: 0.02) .delay(isExpended ? 0 : 0.28)) { content in
                        content
                            .opacity(haveDynamicIsland ? (isExpended ? 1 : 0) : 1)
                    }
                    .geometryGroup()
                    .contentShape(.rect)
                    .gesture(
                        DragGesture().onEnded { _ in
                            manager.dismiss()
                        }
                    )
                } else {
                    RoundedRectangle(cornerRadius: isExpended ? 30 : 18, style: .continuous)
                        .fill(.black)
                        .overlay {
                            ToastContent(haveDynamicIsland, isExpended: isExpended)
                                .frame(width: expendedWidth, height: expendedHeight)
                                .scaleEffect(x: scaleX, y: scaleY)
                        }
                        .frame(
                            width: isExpended ? expendedWidth : dynamicIslandWidth,
                            height: isExpended ? expendedHeight : dynamicIslandHeight
                        )
                        .offset(
                            y: haveDynamicIsland ? topOffest : (isExpended ? safeArea.top + 10 : -80)
                        )
                        // Devices that do not have dynamic island
                        .opacity(haveDynamicIsland ? 1 : (isExpended ? 1 : 0))
                        // Devices that have dynamic island
                        .animation(.linear(duration: 0.02) .delay(isExpended ? 0 : 0.28)) { content in
                            content
                                .opacity(haveDynamicIsland ? (isExpended ? 1 : 0) : 1)
                        }
                        .geometryGroup()
                        .contentShape(.rect)
                        .gesture(
                            DragGesture().onEnded { _ in
                                manager.dismiss()
                            }
                        )
                }
            }
            .onPreferenceChange(ToastTextHeightKey.self) { newHeight in
                textHeight = newHeight
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
            .animation(.bouncy(duration: 0.3, extraBounce: 0), value: isExpended)
        }
    }
    
    @ViewBuilder
    private func ToastContent(_ haveDynamicIsland: Bool, isExpended: Bool) -> some View {
        if let toast = manager.currentToast {
            HStack(spacing: 10) {
                if let icon = toast.icon {
                    renderIcon(icon, size: toast.iconSize, color: toast.iconColor)
                        .symbolEffect(.wiggle, options: .default.speed(1.5), value: isExpended)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    if haveDynamicIsland {
                        Spacer(minLength: 0)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(toast.title)
                            .font(toast.titleFont)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        if !toast.body.isEmpty {
                            Text(toast.body)
                                .font(toast.bodyFont)
                                .foregroundStyle(Color.twNeutral100)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .background(
                        GeometryReader {
                            Color.clear.preference(key: ToastTextHeightKey.self, value: $0.size.height)
                        }
                    )
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, haveDynamicIsland ? 14 : 0)
            }
            .padding(.horizontal, 20)
            .environment(\.layoutDirection, toast.isArabic ? .rightToLeft : .leftToRight)
            .compositingGroup()
            .blur(radius: isExpended ? 0 : 5)
            .opacity(isExpended ? 1 : 0)
        }
    }
    
    @ViewBuilder
    private func renderIcon(_ icon: ToastIcon, size: CGFloat, color: Color) -> some View {
        Group {
            switch icon {
            case .system(let name):
                Image(systemName: name)
                    .resizable()
                    .scaledToFit()
                
            case .custom(let image):
                image
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(width: size, height: size)
        .foregroundStyle(color)
    }
}
