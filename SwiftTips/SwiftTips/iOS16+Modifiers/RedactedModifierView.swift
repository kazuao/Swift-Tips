//
//  Modifier1View.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/11/14.
//

import SwiftUI

struct RedactedModifierView: View {

    @State private var hideContent: Bool = false

    var body: some View {
        // MARK: Hide/Reveal based on user input
        VStack {
            if hideContent {
                sampleView
                // コンテンツの大枠は保持しながらplaceholderを出せる
                    .redacted(reason: .placeholder) // Used to Reveal/Hide Content
            } else {
                sampleView
            }

            Button("Hide") {
                hideContent.toggle()
            }
        }
    }

    var sampleView: some View {
        VStack(alignment: .leading) {
            Image("Photo1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
                .clipShape(Circle())

            Text("What is Lorem Ipsum?")
                .font(.callout)
                .fontWeight(.bold)

            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.")
                .font(.caption2)
                .foregroundColor(.gray)

            Button("Done") {}
                .buttonStyle(.bordered)
                .tint(.cyan)
        }
        .frame(width: 220)
    }
}

struct Modifier1View_Previews: PreviewProvider {
    static var previews: some View {
        RedactedModifierView()
    }
}
