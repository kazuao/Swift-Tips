//
//  ButtonExtension.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/07/20.
//

import SwiftUI

struct ButtonExtension: View {
    var body: some View {
        Text("テキストがボタン化できるよ")
            .font(.largeTitle)
            .onButtonTap {
                print("タップされた")
            }
    }
}

extension View {
    /// Buttonの拡張
    @warn_unqualified_access
    func onButtonTap(_ onTapped: (() -> Void)? = nil) -> some View {
        self.modifier(ButtonTapModifier(onTapped: onTapped))
    }
}

fileprivate struct ButtonTapModifier: ViewModifier {
    var onTapped: (() -> Void)?

    func body(content: Content) -> some View {
        Button {
            onTapped?()
        } label: {
            content
        }
    }
}


struct ButtonExtension_Previews: PreviewProvider {
    static var previews: some View {
        ButtonExtension()
    }
}
