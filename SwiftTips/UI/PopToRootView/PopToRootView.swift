//
//  PopToRootView.swift
//  SwiftTips
//
//  Created by Kazunori Aoki on 2024/04/25.
//

import SwiftUI

enum InnerTab: String {
    case home = "Home"
    case settings = "Settings"
    
    var symbolImage: String {
        switch self {
        case .home:
            return "house"
        case .settings:
            return "gearshape"
        }
    }
}

struct PopToRootView: View {
    
    @State private var activeTab: InnerTab = .home
    @State private var homeStack: NavigationPath = .init()
    @State private var settingStack: NavigationPath = .init()
    @State private var tapCount: Int = .zero
    
    var body: some View {
        TabView(selection: tabSelection) {
            NavigationStack(path: $homeStack) {
                List {
                    NavigationLink("Detail", value: "Detail")
                }
                .navigationTitle("Home")
                .navigationDestination(for: String.self) { value in
                    List {
                        if value == "Detail" {
                            NavigationLink("More", value: "More")
                        }
                    }
                    .navigationTitle(value)
                }
            }
            .tag(InnerTab.home)
            .tabItem {
                Image(systemName: InnerTab.home.symbolImage)
                Text(InnerTab.home.rawValue)
            }
            
            NavigationStack(path: $settingStack) {
                List {
                    
                }
                .navigationTitle("Settings")
            }
            .tag(InnerTab.settings)
            .tabItem {
                Image(systemName: InnerTab.settings.symbolImage)
                Text(InnerTab.settings.rawValue)
            }
        }
    }
    
    var tabSelection: Binding<InnerTab> {
        return .init(
            get: {
                return activeTab
            },
            set: { newValue in
                if newValue == activeTab {
                    switch newValue {
                    case .home: 
                        homeStack = .init()
                    case .settings:
                        settingStack = .init()
                    }
                } else {
                    tapCount = .zero
                }
                activeTab = newValue
            })
    }
}

#Preview {
    PopToRootView()
}
