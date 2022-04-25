//
//  RootView.swift
//  SwiftUI-TabView
//
//  Created by kazunori.aoki on 2022/04/04.
//

import SwiftUI

struct RootView: View {

    @EnvironmentObject private var tabs: Tabs

    var title: String

//    @Binding var selection: Int

    var body: some View {
        List {
            Button {

                if title == "Home" {
                    tabs.selection = .profile
                } else {
                    tabs.selection = .home
                }

            } label: {
                Text("Switch tab to \(title == "Home" ? "Profile" : "Home")")
            }

            ForEach(0..<100, id: \.self) { index in
                NavigationLink("Index \(index)") {
                    Text("\(title) / \(index)")
                }
            }
        }
        .navigationTitle(title)
    }
}
