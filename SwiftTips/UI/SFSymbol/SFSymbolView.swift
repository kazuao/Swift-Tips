//
//  SFSymbolView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/10/26.
//

import SwiftUI

// TabBarのSFSymbolをfillにしない
// https://dev.classmethod.jp/articles/tabview-tabitem-systemvariant/
struct SFSymbolView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "heart")
                .symbolVariant(.none)

            Image(systemName: "heart")
                .symbolVariant(.fill)

            Image(systemName: "heart")
                .symbolVariant(.circle)

            Image(systemName: "heart")
                .symbolVariant(.square)

            Image(systemName: "heart")
                .symbolVariant(.rectangle)

            Image(systemName: "heart")
                .symbolVariant(.slash)

            Spacer()

            TabView {
                // MARK: iOS15+
                Image(systemName: "heart")
                    .font(.system(size: 100))
                    .tabItem {
                        Image(systemName: "heart")
                            .environment(\.symbolVariants, .none)
                    }

                // MARK: iOS14-
                Image(uiImage: UIImage(systemName: "heart")!)
                    .font(.system(size: 100))
                    .tabItem {
                        Image(uiImage: UIImage(systemName: "heart")!)
                    }
            }
        }
        .font(.system(size: 60))
    }
}

struct SFSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbolView()
    }
}
