//
//  SOnContinueUserActivityView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/13.
//

import SwiftUI

struct SOnContinueUserActivityView: View {

    var colors = ["Red", "Green", "Yellow", "Blue", "Pink", "Purple"]
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    @State var selectedColor: String? = nil

        var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(colors, id: \.self) { color in
                            NavigationLink(destination: ColorDetailView(color: color),
                                           tag: color,
                                           selection: $selectedColor) {
                                Image(color)
                            }
                        }
                    }
                    .onContinueUserActivity("showColor") { userActivity in
                        if let color = userActivity.userInfo?["colorName"] as? String {
                            selectedColor = color
                        }
                    }
                }
            }
    }
}

struct ColorDetailView: View {
    let color: String

    var body: some View {
        Text(color)
    }
}
