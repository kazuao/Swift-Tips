//
//  Buttons.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/02/16.
//

import SwiftUI

struct Buttons: View {
    var body: some View {
        VStack(spacing: 60) {

            Button("Automatic") {}
            .buttonStyle(.automatic)

            Button("Bordered") {}
            .buttonStyle(.bordered)

            Button("BorderedProminent") {}
            .buttonStyle(.borderedProminent)

            Button("Borderless") {}
            .buttonStyle(.borderless)

            Button("Plain") {}
            .buttonStyle(.plain)
        }
        .font(.title)
        .accentColor(.purple)
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
