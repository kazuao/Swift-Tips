//
//  CustomFormatStyleView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/07.
//

import SwiftUI

struct CustomFormatStyleView: View {

    @State private var intText: Int = 0
    @State private var gridBlockSize: String = ""

    var body: some View {

        let numberFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.minimum = .init(integerLiteral: 1)
            formatter.maximum = .init(integerLiteral: Int.max)
            formatter.generatesDecimalNumbers = false
            formatter.maximumFractionDigits = 0
            return formatter
        }()

        VStack {
//            TextField("", value: $intText, format: .ranged(1...Int.max))
//            TextField("", value: $gridBlockSize, formatter: numberFormatter)
        }
    }
}

struct RangeIntegerStyle: ParseableFormatStyle {

    var parseStrategy: RangeIntegerStrategy = .init()
    let range: ClosedRange<Int>

    func format(_ value: Int) -> String {
        let constrainedValue = min(max(value, range.lowerBound), range.upperBound)
        return "\(constrainedValue)"
    }
}

struct RangeIntegerStrategy: ParseStrategy {
    func parse(_ value: String) throws -> Int {
        return Int(value) ?? 1
    }
}

extension FormatStyle where Self == RangeIntegerStyle {
    static func ranged(_ range: ClosedRange<Int>) -> RangeIntegerStyle {
        return RangeIntegerStyle(range: range)
    }
}

struct CustomFormatStyleView_Previews: PreviewProvider {
    static var previews: some View {
        CustomFormatStyleView()
    }
}
