//
//  MonospacedFontView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/05/12.
//

import SwiftUI

struct MonospacedFontView: View {
    var body: some View {
        VStack {
            VStack {
              Text("12:34:56")
              Text("07:18:19")
            }
            .font(.system(size: 72, weight: .regular, design: .monospaced))
            // monospacedを使うと等幅フォントになる
            // この場合、「:」も等幅フォントになる
            // 0もスラッシュが入る

            Spacer()
                .frame(height: 20)

            VStack {
              Text("12:34:56")
              Text("07:18:19")
            }
            .font(.system(size: 72))
            .monospacedDigit()
            // こっちの場合、数字のみ等幅フォントになる
        }
    }
}

struct MonospacedFontView_Previews: PreviewProvider {
    static var previews: some View {
        MonospacedFontView()
    }
}
