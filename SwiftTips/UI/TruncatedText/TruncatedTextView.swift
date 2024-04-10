//
//  TruncatedTextView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2023/06/14.
//

import SwiftUI

// ref: https://note.com/taatn0te/n/nc288cb250e5f

struct TruncatedTextView: View {
    let text = "吾輩は猫である。名前はまだ無い。どこで生れたかとんと見当がつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。吾輩はここで始めて人間というものを見た。"

    var body: some View {
        VStack(spacing: 40) {
            Text(text)
                .lineLimit(3)

            TruncatedText(
                text,
                lineLimit: 3,
                ellipsis: .init(text: "More", color: .blue)
            )
        }
        .padding()
    }
}

struct TruncatedTextView_Previews: PreviewProvider {
    static var previews: some View {
        TruncatedTextView()
    }
}

struct TruncatedText: View {
    struct Ellipsis {
        var text: String = ""
        var color: Color = .black
        var fontSize: CGFloat?
    }

    @State private var truncated: Bool = false
    @State private var truncatedText: String

    let lineLimit: Int
    let lineSpacing: CGFloat
    let font: UIFont
    let ellipsis: Ellipsis

    private var text: String
    private var ellipsisPrefixText: String {
        return truncated ? "..." : ""
    }

    private var ellipsisText: String {
        return truncated ? ellipsis.text : ""
    }

    private var ellipsisFont: Font {
        if let fontSize = ellipsis.fontSize {
            return Font(font.withSize(fontSize))
        } else {
            return Font(font)
        }
    }

    init(
        _ text: String,
        lineLimit: Int,
        lineSpacing: CGFloat = 2,
        font: UIFont = .preferredFont(forTextStyle: .body),
        ellipsis: Ellipsis = Ellipsis()
    ){
        self.text = text
        self.lineLimit = lineLimit
        self.lineSpacing = lineSpacing
        self.font = font
        self.ellipsis = ellipsis

        _truncatedText = State(wrappedValue: text)
    }

    var body: some View {
        Group {
            Text(truncatedText)
            + Text(ellipsisPrefixText)
            + Text(ellipsisText)
                .font(ellipsisFont)
                .foregroundColor(ellipsis.color)
        }
        .multilineTextAlignment(.leading)
        .lineLimit(lineLimit)
        .lineSpacing(lineSpacing)
        .background(
            Text(text)
                .hidden()
                .lineLimit(lineLimit)
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                let size = CGSize(width: proxy.size.width, height: .greatestFiniteMagnitude)
                                let attributes: [NSAttributedString.Key: Any] = [.font: font]

                                var low = 0
                                var heigh = truncatedText.count
                                var mid = heigh

                                while (heigh - low) > 1 {
                                    let attributedText = NSAttributedString(
                                        string: truncatedText + ellipsisPrefixText + ellipsisText,
                                        attributes: attributes
                                    )

                                    let boundRect = attributedText.boundingRect(
                                        with: size,
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        context: nil
                                    )

                                    if boundRect.size.height > proxy.size.height {
                                        truncated = true
                                        heigh = mid
                                        mid = (heigh + low) / 2
                                    } else {
                                        if mid == text.count {
                                            break
                                        } else {
                                            low = mid
                                            mid = (low + heigh) / 2
                                        }
                                    }
                                    truncatedText = String(text.prefix(mid))
                                }
                            }
                    }
                )
        )
        .font(Font(font))
    }
}
