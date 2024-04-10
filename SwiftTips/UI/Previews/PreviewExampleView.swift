//
//  PreviewExampleView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/24.
//

import SwiftUI

struct PreviewExampleView: View {
    let isRed: Bool
    let isSmall: Bool

    var body: some View {

        HStack {
            Text(isRed ? "🍎" : "🍏")
            Text("Apple")
        }
        .font(isSmall ? .caption : .title)
        .padding()
    }
}

