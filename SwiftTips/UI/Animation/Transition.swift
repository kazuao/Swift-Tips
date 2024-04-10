//
//  Transition.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/06/07.
//

import SwiftUI

struct Transition: View {
    @State private var visible: Bool = false

    var body: some View {

        let transition = AnyTransition
            .asymmetric(insertion: .slide, removal: .scale)
            .combined(with: .opacity)

        VStack {
            Toggle("Visible", isOn: $visible)

//            if visible {
//                Text("Hello world")
//                    .transition(transition)
//            } else {
//                Text("Hello, world")
//                    .transition(transition)
//            }

            // 上記を書き直した感じ
            Text("Hello, world")
                .id(visible)
                .transition(transition)
        }
        .padding()
        .animation(.default.speed(0.5), value: visible)
    }
}

struct Transition_Previews: PreviewProvider {
    static var previews: some View {
        Transition()
    }
}
