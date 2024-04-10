//
//  SearchableView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/08/16.
//

import SwiftUI

struct SearchableView: View {

    @State private var text: String = "hoge"

    var body: some View {
        // TODO: 使い方がわからん
        // https://danielsaidi.com/blog/2022/08/03/conditionally-searchable-swiftui-views?utm_source=swiftlee&utm_medium=swiftlee_weekly&utm_campaign=issue_127
        searchable(text: $text, prompt: "search")
    }
}

struct SearchableView_Previews: PreviewProvider {
    static var previews: some View {
        SearchableView()
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
extension View {
    @ViewBuilder
    func searchable(if condition: Bool,
                    text: Binding<String>,
                    placement: SearchFieldPlacement = .automatic,
                    prompt: String) -> some View {
        if condition {
            self.searchable(text: text, placement: placement, prompt: prompt)
        } else {
            self
        }
    }
}
