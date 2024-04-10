//
//  FirstAppear.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/11/10.
//

import SwiftUI

// usage: .onFirstAppear { /* some process */ }
extension View {
    func onFirstAppear(_ action: @escaping () -> Void) -> some View {
        modifier(FirstAppear(action: action))
    }
}

private struct FirstAppear: ViewModifier {
    let action: () -> Void

    @State private var hasAppeared: Bool = false

    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !hasAppeared else { return }
                hasAppeared = true
                action()
            }
    }
}
