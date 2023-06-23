//
//  EmptyLink.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/28.
//

import SwiftUI

@available(iOS 16, *)
struct EmptyLinkView: View {
    @State private var isActive: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Button("画面遷移") { isActive = true }

                // 🎄 Readable 🎁
                EmptyLink(isActive: $isActive) {
                    ChildView()
                }
            }
            .navigationTitle("18日目")
        }
    }
}

struct ChildView: View {
    var body: some View {
        Text("Child")
            .navigationTitle("Child")
    }
}

struct EmptyLink<Destination: View>: View {
    private var navigationLink: () -> NavigationLink<EmptyView, Destination>

    @available(iOS 16, *)
    init(
        isActive: Binding<Bool>,
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        navigationLink = {
            NavigationLink(destination: destination(), isActive: isActive, label: { EmptyView() })
        }
    }

    init<V: Hashable>(
        tag: V,
        selection: Binding<V?>,
        @ViewBuilder destination: @escaping () -> Destination
    ) {
        navigationLink = {
            NavigationLink(tag: tag,
                           selection: selection,
                           destination: destination,
                           label: { EmptyView() })
        }
    }

    var body: some View {
        navigationLink()
    }
}

struct EmptyLink_Previews: PreviewProvider {
    static var previews: some View {
        EmptyLinkView()
    }
}
