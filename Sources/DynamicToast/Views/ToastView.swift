//
//  ToastView.swift
//  DynamicToast
//
//  Created by Alhassan AlMakki on 08/09/1447 AH.
//

import SwiftUI
import PhosphorSwift

@MainActor
public struct ToastView: View {
    private var manager = ToastManager.shared
    
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
            let expendedWidth = size.width - 20
            let iconSize = manager.currentToast?.iconSize ?? 32
            let verticalPadding: CGFloat = haveDynamicIsland ? 55 : 30
            let defaultHeight: CGFloat = haveDynamicIsland ? 90 : 70
            
            let expendedHeight: CGFloat = max(defaultHeight, iconSize + verticalPadding)
            let scaleX: CGFloat = isExpended ? 1 : (dynamicIslandWidth / expendedWidth)
            let scaleY: CGFloat = isExpended ? 1 : (dynamicIslandHeight / expendedHeight)
            
            ZStack {
                if #available(iOS 26.0, *) {
                    ConcentricRectangle(
                        corners: .concentric(minimum: .fixed(30)), isUniform: true
                    )
                    .fill(Color.twNeutral800)
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
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
            .animation(.bouncy(duration: 0.3, extraBounce: 0), value: isExpended)
        }
    }
    
    @ViewBuilder
    private func ToastContent(_ haveDynamicIsland: Bool, isExpended: Bool) -> some View {
        if let toast = manager.currentToast {
            HStack(alignment: .center, spacing: 10) {
                if let icon = toast.icon {
                    renderIcon(icon, size: toast.iconSize, color: toast.iconColor)
                        .symbolEffect(.wiggle, options: .default.speed(1.5), value: isExpended)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(toast.title)
                        .font(toast.titleFont)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)
                    
                    if !toast.body.isEmpty {
                        Text(toast.body)
                            .font(toast.bodyFont)
                            .foregroundStyle(Color.twSlate100)
                            .multilineTextAlignment(.leading)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, toast.icon == nil ? 12 : 0)
                .lineLimit(1)
            }
            .padding(.horizontal, 30)
            .padding(.top, haveDynamicIsland ? 42 : 15)
            .padding(.bottom, 16)
            .frame(maxHeight: .infinity, alignment: .bottom)
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
