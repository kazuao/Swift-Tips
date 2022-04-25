//
//  ColorSchemePreview.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/24.
//

import SwiftUI

struct ColorSchemePreview<Content>: View where Content: View {

    let content: () -> Content

    private var colorSchemes: [ColorScheme] {
        [.light, .dark]
    }

    var body: some View {
        ForEach(colorSchemes, id: \.self) { colorScheme in
            content()
                .preferredColorScheme(colorScheme)
        }
    }
}

// MARK: Usage
struct ColorSchemePreview_Previews: PreviewProvider {
    static var previews: some View {
        ColorSchemePreview {
            PreviewExampleView(isRed: true, isSmall: false)
                .previewLayout(.sizeThatFits)
        }
    }
}
