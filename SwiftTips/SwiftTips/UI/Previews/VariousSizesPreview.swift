//
//  VariousSizesPreview.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/24.
//

import SwiftUI

extension PreviewDevice: Hashable {}

extension PreviewProvider {
    // 文字サイズでの違い
    static var sizes: [ContentSizeCategory] {
        get { [.extraSmall, .large, .accessibilityExtraExtraExtraLarge] }
    }

    // Deviceでの違い
    static var mmmDesigns: [PreviewDevice] {
        get {
            [.init(stringLiteral: "iPhone 13 Mini"),
             .init(stringLiteral: "iPhone 13"),
             .init(stringLiteral: "iPhone 13 Pro Max")]
        }
    }
}

// MARK: Usage
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(mmmDesigns, id: \.self) { deviceName in
            ForEach(sizes, id: \.self) { contentSize in
                PreviewExampleView()
                    .environment(\.sizeCategory, contentSize)
                    .previewDevice(deviceName)
            }
        }
    }
}
