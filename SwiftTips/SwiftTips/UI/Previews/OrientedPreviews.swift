//
//  OrientedPreviews.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/24.
//

import SwiftUI

struct OrientedPreviews<Content>: View where Content: View {

    let content: () -> Content

    private struct Orientation: Identifiable {
        let id = UUID()
        let orientation: InterfaceOrientation
    }

    private var orientations: [Orientation] {
        [.init(orientation: .portrait),
//         .init(orientation: .portraitUpsideDown),
         .init(orientation: .landscapeLeft),
         .init(orientation: .landscapeRight)]
    }

    var body: some View {
        ForEach(orientations, id: \.id) { orientation in
            content()
                .previewInterfaceOrientation(orientation.orientation)
        }
    }
}

// MARK: Usage
struct OrientedPreviews_Previews: PreviewProvider {
    static var previews: some View {
        OrientedPreviews {
            PreviewExampleView(isRed: true, isSmall: false)
                .previewLayout(.sizeThatFits)
        }
    }
}
