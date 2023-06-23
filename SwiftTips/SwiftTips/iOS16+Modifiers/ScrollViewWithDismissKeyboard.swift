//
//  ScrollViewWithDismissKeyboard.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2023/03/09.
//

import SwiftUI

struct ScrollViewWithDismissKeyboard: View {

    @State private var text: String = ""

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                TextField("Type Here", text: $text)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
        }
        // .interactively: スクロールと一緒に下げる
        // .immediately: スクロールしたらシュッと下げる
        // .never: 下げない
        .scrollDismissesKeyboard(.immediately)
    }
}
