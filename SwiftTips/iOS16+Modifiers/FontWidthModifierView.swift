//
//  Modifier2View.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/11/14.
//

import SwiftUI

struct FontWidthModifierView: View {
    var body: some View {
        Text("Kavsoft")
            .font(.system(size: 45))
            .fontWeight(.bold)
            // MARK: New iOS 16+ Modifier
//            .fontWidth(.standard) // 普通
//            .fontWidth(.compressed) // fontがぎゅってなる
//            .fontWidth(.condensed) // ちょっとぎゅってなる
            .fontWidth(.expanded) // ひろがる
    }
}

struct Modifier2View_Previews: PreviewProvider {
    static var previews: some View {
        FontWidthModifierView()
    }
}
