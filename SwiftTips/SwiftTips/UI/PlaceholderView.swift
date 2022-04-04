//
//  PlaceholderView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/02/17.
//

import SwiftUI

struct Article {
    let title: String
    let author: String
}

struct PlaceholderView: View {

    @State private var article: Article?

    var body: some View {
        VStack(alignment: .leading) {
            Text(article?.title ?? .placeholder(length: 30))
                .font(.headline)

            Text(article?.author ?? .placeholder(length: 15))
                .font(.subheadline)

            Text("avanderlee.com - SwiftLee")
                .font(.caption)
                .italic()
                .unredacted() // Placeholderを使わない
        }
        .padding()
//        .redacted(reason: article == nil ? .placeholder : []) // extensionを利用しない場合
        .redacted(if: article == nil)
    }
}

extension String {
    // Placeholderように文字数を指定したStringを返却する
    static func placeholder(length: Int) -> String {
        return String(Array(repeating: "X", count: length))
    }
}

extension View {
    @ViewBuilder
    func redacted(if condition: @autoclosure() -> Bool) -> some View {
        return redacted(reason: condition() ? .placeholder : [])
    }
}

struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderView()
    }
}
