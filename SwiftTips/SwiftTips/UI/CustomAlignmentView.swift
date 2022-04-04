//
//  CustomAlignmentView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/02/17.
//

import SwiftUI

struct CustomAlignmentView: View {

    @State private var counter = Date()

    var body: some View {
        VStack {
            Text("Timer")
                .font(.title)
                .frame(maxWidth: .infinity)

            HStack(spacing: 16) {
                Text(counter.formatted(.iso8601.time(includingFractionalSeconds: true)))
                    .font(.system(.body, design: .monospaced))
                    .alignmentGuide(.customCenter) { context in
                        context.width / 4
//                        context[HorizontalAlignment.center]
                    }

                Button(role: .destructive) {
                    counter = Date()
                } label: {
                    Image(systemName: "gobackward")
                        .imageScale(.large)
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct CustomCenter: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        return context[HorizontalAlignment.center]
    }
}

extension HorizontalAlignment {
    static let customCenter: HorizontalAlignment = .init(CustomCenter.self)
}

struct CustomAlignmentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlignmentView()
    }
}
