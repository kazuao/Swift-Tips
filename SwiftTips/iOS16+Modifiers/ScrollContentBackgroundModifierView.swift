//
//  Modifier4View.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/11/14.
//

import SwiftUI

struct ScrollContentBackgroundModifierView: View {
    var body: some View {
        List {
            Text("Hello")
            Text("Hello")
            Text("Hello")
        }
        // MARK: iOS16+
        .scrollContentBackground(.hidden) // 背景を削除できる
        .background(Color.red.gradient)
    }
}

struct Modifier4View_Previews: PreviewProvider {
    static var previews: some View {
        ScrollContentBackgroundModifierView()
    }
}
