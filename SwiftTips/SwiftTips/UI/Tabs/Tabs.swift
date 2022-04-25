//
//  Tabs.swift
//  SwiftUI-TabView
//
//  Created by kazunori.aoki on 2022/04/04.
//

import SwiftUI

class Tabs: ObservableObject {
    @Published var selection: Tab = .home

    init(selection: Tab = .home) {
        self.selection = selection
    }
}

enum Tab {
    case home, profile
}
