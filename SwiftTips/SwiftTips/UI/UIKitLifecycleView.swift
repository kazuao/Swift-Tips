//
//  UIKitLifecycleView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/28.
//

import SwiftUI

// ref: https://qiita.com/naoKyo/items/862a2cb1664a8dad4128

struct UIKitLifecycleView: View {
    var body: some View {
        Text("Hello, World!")
            .onViewWillAppear {
                print("View will appear")
            }
    }
}

struct UIKitLifecycleView_Previews: PreviewProvider {
    static var previews: some View {
        UIKitLifecycleView()
    }
}
