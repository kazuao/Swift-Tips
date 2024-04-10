//
//  Modifier3View.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/11/14.
//

import SwiftUI

struct InnerOrDropShadowModifierView: View {
    var body: some View {
        Rectangle()
        // inner of drop shadows on iOS16+
//            .fill(.red.shadow(.inner(radius: 25))) // 中に
            .fill(.red.shadow(.drop(radius: 25))) // 外に
            .frame(width: 200, height: 200)
    }
}

struct Modifier3View_Previews: PreviewProvider {
    static var previews: some View {
        InnerOrDropShadowModifierView()
    }
}
