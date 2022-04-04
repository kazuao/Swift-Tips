//
//  SeceneStorageView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/03/18.
//

import SwiftUI

struct SceneStorageView: View {

    @SceneStorage("selectTab") private var selectTab = 0

    var body: some View {
        TabView(selection: $selectTab) {
            NavigationView {
                TimerView()
            }
            .tabItem {
                Image(systemName: "timer")
                Text("Timer")
            }
            .tag(0)

            NavigationView {
                InsightsContainerView()
                    .navigationTitle("Insights")
            }
            .tabItem {
                Image(systemName: "chart.bar")
                Text("insights")
            }
            .tag(1)
        }
    }
}

struct TimerView: View {

    var body: some View {
        Text("")
    }
}

struct InsightsContainerView: View {

    var body: some View {
        Text("")
    }
}

struct SeceneStorageView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SceneStorageView()
        }
    }
}
