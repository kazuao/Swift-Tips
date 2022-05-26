//
//  StateViewModifier.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/05/10.
//

import SwiftUI

struct StateViewModifier: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .switchBorder()
    }
}

struct SwitchBorderModifier: ViewModifier {
    @State var isOn = false

    func body(content: Content) -> some View {
        VStack {
            content.border(isOn ? .red : .blue)
            Toggle("Border", isOn: $isOn)
        }
    }
}

extension View {
    func switchBorder() -> some View {
        self.modifier(SwitchBorderModifier())
    }
}

struct StateViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        StateViewModifier()
    }
}
