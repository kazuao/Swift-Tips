//
//  CustomButtonStyleView.swift
//  SwiftTips
//
//  Created by Kazunori Aoki on 2024/07/01.
//

import SwiftUI

// https://www.swiftwithvincent.com/blog/bad-practice-not-using-a-buttonstyle?utm_source=swiftlee&utm_medium=swiftlee_weekly&utm_campaign=issue_122
struct CustomButtonStyleView: View {
    var body: some View {
        Button {
            //
        } label: {
            Text("Click Me")
        }
        .buttonStyle(BlueRoundedButtonStyle())
    }
}


fileprivate struct BlueRoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .padding(32)
            .background(
                configuration.isPressed ? .blue.opacity(0.5) : .blue
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
            )
    }
}
