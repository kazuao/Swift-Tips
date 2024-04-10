//
//  BoolPreviews.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/24.
//

import SwiftUI

// Boolを繰り返し表示できる
struct BoolPreview<Content>: View where Content: View {
    let content: (Bool) -> Content

    var body: some View {
        ForEach([true, false], id: \.self) { boolValue in
            content(boolValue)
        }
    }
}

// MARK: Usage
struct BoolPreviews_Previews: PreviewProvider {
    static var previews: some View {
        BoolPreview { isRed in
            BoolPreview { isSmall in
            PreviewExampleView(isRed: isRed, isSmall: isSmall)
                .previewLayout(.sizeThatFits)
            }
        }
    }
}
