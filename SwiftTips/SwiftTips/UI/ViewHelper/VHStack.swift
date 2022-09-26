//
//  VHStack.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/08/26.
//

import SwiftUI

/// Viewの横幅によって、VStackとHStackを出し分ける
struct VHStack<Content: View>: View {

    // MARK: Environment
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    // MARK: Initialize
    @ViewBuilder var content: () -> Content


    // MARK: View
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack(content: content)
        } else {
            HStack(content: content)
        }
    }
}

struct VHStack_Previews: PreviewProvider {
    static var previews: some View {
        VHStack {
            Text("1")
            Text("2")
        }
    }
}
