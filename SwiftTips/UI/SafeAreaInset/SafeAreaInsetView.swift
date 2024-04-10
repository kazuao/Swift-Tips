//
//  SafeAreaInsetView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/11/17.
//

import SwiftUI

struct SafeAreaInsetView: View {

    struct Message: Identifiable {
        var id = UUID()
        var text: String
    }

    @State private var newMessageText: String = ""
    @State private var messages: [Message] = [
        .init(text: "Message1"),
        .init(text: "Message2"),
        .init(text: "Message3"),
        .init(text: "Message4"),
        .init(text: "Message5"),
        .init(text: "Message6"),
        .init(text: "Message7"),
        .init(text: "Message8"),
        .init(text: "Message9"),
    ]

    var body: some View {
        List(messages) { message in
            Text(message.text)
        }
        .safeAreaInset(edge: .bottom) {
            TextField("New Message", text: $newMessageText)
                .padding()
                .textFieldStyle(.roundedBorder)
                .background(.ultraThinMaterial)
                .onSubmit {
                    // append message
                }
        }
    }
}

struct SafeAreaInsetView_Previews: PreviewProvider {
    static var previews: some View {
        SafeAreaInsetView()
    }
}
