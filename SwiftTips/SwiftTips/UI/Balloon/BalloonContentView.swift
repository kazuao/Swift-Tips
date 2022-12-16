//
//  BalloonContentView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/11/08.
//

import SwiftUI

// ref: https://qiita.com/yuppejp/items/92429a0fc8440f9da487

struct BalloonContentView: View {
    var body: some View {
        VStack {
            Text("iOS表示サンプル")
                .padding(4)
            BalloonText(text: "SwiftUIから\nこんにちは!")
                .padding(4)
            BalloonText(text: "逆向きの吹き出しです", mirrored: true)
                .padding(4)
            BalloonText(text: "長いテキストの表示例です。テキストの幅と高さに合わせて、吹き出しの大きさも自動的に連動して表示されます。")
                .padding(4)
        }
    }
}

struct BalloonContentView_Previews: PreviewProvider {
    static var previews: some View {
        BalloonContentView()
    }
}

struct BalloonText: View {
    var text: String
    var color: Color = .init(UIColor(red: 109/255, green: 230/255, blue: 123/255, alpha: 1.0))
    var mirrored: Bool = false

    var body: some View {
        let cornerRadius: Double = 8.0

        Text(text)
            .padding(8)
            .padding(.leading, 4 + (mirrored ? cornerRadius / 2 : 0))
            .padding(.trailing, 4 + (!mirrored ? cornerRadius / 2 : 0))
            .padding(.vertical, 2)
            .background {
                BalloonShape(cornerRadius: cornerRadius, color: color, mirrored: mirrored)
            }
    }
}

struct BalloonShape: View {
    var cornerRadius: Double
    var color: Color
    var mirrored: Bool

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let tailSize = CGSize(width: cornerRadius / 2, height: cornerRadius / 2)
                let shapeRect = CGRect(x: 0, y: 0, width: geometry.size.width, height: geometry.size.height)

                path.addArc(center: .init(x: shapeRect.minX + cornerRadius, y: shapeRect.minY + cornerRadius),
                            radius: cornerRadius,
                            startAngle: .init(degrees: 180),
                            endAngle: .init(degrees: 279),
                            clockwise: false
                )

                path.addArc(center: .init(x: shapeRect.maxX - cornerRadius - tailSize.width,
                                          y: shapeRect.minY + cornerRadius),
                            radius: cornerRadius,
                            startAngle: .init(degrees: 270),
                            endAngle: .init(degrees: 270 + 45),
                            clockwise: false
                )

                path.addQuadCurve(to: .init(x: shapeRect.maxX, y: shapeRect.minY),
                                  control: .init(x: shapeRect.maxX - (tailSize.width / 2), y: shapeRect.minY)
                )

                path.addQuadCurve(to: .init(x: shapeRect.maxX - tailSize.width,
                                            y: shapeRect.minY + (cornerRadius / 2) + tailSize.height),
                                  control: .init(x: shapeRect.maxX - (tailSize.width / 2), y: shapeRect.minY)
                )

                path.addArc(center: .init(x: shapeRect.maxX - cornerRadius - tailSize.width,
                                          y: shapeRect.maxY - cornerRadius),
                            radius: cornerRadius,
                            startAngle: .init(degrees: 0),
                            endAngle: .init(degrees: 90),
                            clockwise: false
                )

                path.addArc(center: .init(x: shapeRect.minX + cornerRadius, y: shapeRect.maxY - cornerRadius),
                            radius: cornerRadius,
                            startAngle: .init(degrees: 90),
                            endAngle: .init(degrees: 180),
                            clockwise: false
                )
            }
            .fill(color)
            .rotation3DEffect(.degrees(mirrored ? 180 : 0), axis: (x: 0, y: 1, z: 0))
        }
    }
}
