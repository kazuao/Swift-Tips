//
//  OppositeColorView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/02.
//

import SwiftUI

// ref: https://qiita.com/SNQ-2001/items/7ebfadb553c2682ea69b
struct OppositeColorView: View {

    @State private var percentage: CGFloat = 100

    var body: some View {
        VStack(alignment: .center) {
            batteryShape.overlay(batteryText)

            Slider(value: $percentage, in: 0...100)
                .frame(width: 250)
        }
    }

    var batteryText: some View {
        Text("\(Int(percentage))")
            .font(.system(size: 70, weight: .black))
            .foregroundColor(.white)
            .blendMode(.difference)
    }

    var batteryShape: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.red, lineWidth: 6)
                .frame(width: 250, height: 120)

            RoundedRectangle(cornerRadius: 10)
                .frame(width: 230 * (percentage / 100), height: 100, alignment: .leading)
                .alignmentGuide(HorizontalAlignment.center, computeValue: { _ in 115 })
        }
    }
}

struct OppositeColorView_Previews: PreviewProvider {
    static var previews: some View {
        OppositeColorView()
    }
}
