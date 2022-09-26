//
//  Toast.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/06/21.
//

import SwiftUI

struct Toast: ViewModifier {
    static let short: TimeInterval = 2
    static let long: TimeInterval = 3.5

    enum `Type` {
        case toast
        case banner
    }

    let type: Type
    let message: String
    @Binding var isShowing: Bool
    let config: ToastConfig

    func body(content: Content) -> some View {
        ZStack {
            content
            toastView
        }
    }

    private var toastView: some View {
        VStack {
            if type == .toast {
                Spacer()
            }

            if isShowing {
                Group {
                    Text(message)
                        .multilineTextAlignment(.center)
                        .foregroundColor(config.textColor)
                        .font(config.font)
                        .padding(8)
                }
                .background(config.backgroundColor)
                .cornerRadius(8)
                .onTapGesture {
                    isShowing = false
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + config.duration) {
                        isShowing = false
                    }
                }
            }

            if type == .banner {
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 18)
        .animation(config.animation, value: isShowing)
        .transition(config.transition)
    }
}

struct ToastConfig {
    let textColor: Color
    let font: Font
    let backgroundColor: Color
    let duration: TimeInterval
    let transition: AnyTransition
    let animation: Animation

    init(textColor: Color = .white,
         font: Font = .system(size: 14),
         backgroundColor: Color = .black.opacity(0.588),
         duration: TimeInterval = Toast.short,
         transition: AnyTransition = .opacity,
         animation: Animation = .linear(duration: 0.3))
    {
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
        self.duration = duration
        self.transition = transition
        self.animation = animation
    }
}

extension View {
    func toast(message: String, isShowing: Binding<Bool>, config: ToastConfig) -> some View {
        self.modifier(Toast(type: .toast, message: message, isShowing: isShowing, config: config))
    }

    func toast(message: String, isShowing: Binding<Bool>, duration: TimeInterval) -> some View {
        self.modifier(Toast(type: .toast, message: message, isShowing: isShowing, config: .init(duration: duration)))
    }

    func banner(message: String, isShowing: Binding<Bool>, config: ToastConfig) -> some View {
        self.modifier(Toast(type: .banner, message: message, isShowing: isShowing, config: config))
    }

    func banner(message: String, isShowing: Binding<Bool>, duration: TimeInterval) -> some View {
        self.modifier(Toast(type: .banner, message: message, isShowing: isShowing, config: .init(duration: duration)))
    }
}
