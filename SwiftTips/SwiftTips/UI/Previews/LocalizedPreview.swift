//
//  LocalizedPreview.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/24.
//

import SwiftUI

struct LocalizePreview<Content>: View where Content: View {

    let content: () -> Content

    private var localizations: [Locale] {
        Bundle.main.localizations
            .map(Locale.init)
            .filter { $0.identifier != "base" }
    }

    var body: some View {
        ForEach(localizations, id: \.self) { locale in
            content()
                .environment(\.locale, locale)
        }
    }
}

// MARK: Usage
struct LocalizedPreview_Previews: PreviewProvider {
    static var previews: some View {
        LocalizePreview {
            PreviewExampleView(isRed: true, isSmall: false)
                .previewLayout(.sizeThatFits)
        }
    }
}
