//
//  TabsView.swift.swift
//  SwiftUI-TabView
//
//  Created by kazunori.aoki on 2022/04/04.
//

import SwiftUI

struct TabsView: View {

    //    @State private var selection: Int = 1
    @StateObject private var tabs = Tabs(selection: .profile)

    var body: some View {
        TabView(selection: $tabs.selection) {

            NavigationView {
                RootView(title: "Home")
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            .tag(Tab.home) // selectionを使用したい場合にtagを設置する

            
            NavigationView {
                RootView(title: "Profile")
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
            .tag(Tab.profile)
            .badge("!") // 文字列も使える

        }
        // ポッチが出る
        // tabItemを使用する場合は消す
        //        .tabViewStyle(.page(indexDisplayMode: .always))
        .environmentObject(tabs)
        #if os(macOS)
        .padding()
        #endif
    }
}
