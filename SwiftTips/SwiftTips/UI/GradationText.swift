//
//  GradationText.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/02/16.
//

import SwiftUI

struct GradationText: View {
    var body: some View {
        
        if #available(iOS 15, *) {
            Text("The simplicity of Apple.\nIn a credit card.")
                .font(Font.system(size: 46, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundStyle(
                    LinearGradient(colors: [.red, .blue, .green, .yellow],
                                   startPoint: .leading,
                                   endPoint: .trailing)
                )
        } else {
            Text("The simplicity of Apple.\nIn a credit card.")
                .font(.system(size: 46, weight: .bold))
                .foregroundLinearGradient(colors: [.red, .blue, .green, .yellow],
                                          startPoint: .leading,
                                          endPoint: .trailing)
                .multilineTextAlignment(.center)
        }
    }
}

extension Text {
    public func foregroundLinearGradient(colors: [Color],
                                         startPoint: UnitPoint,
                                         endPoint: UnitPoint) -> some View {
        return self.overlay(
            LinearGradient(colors: colors,
                           startPoint: startPoint,
                           endPoint: endPoint)
                .mask(self))
    }
}

struct GradationText_Previews: PreviewProvider {
    static var previews: some View {
        GradationText()
    }
}
