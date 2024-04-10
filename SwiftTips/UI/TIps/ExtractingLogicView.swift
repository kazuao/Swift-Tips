//
//  ExtractingLogicView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/26.
//

import SwiftUI

/*
 Viewの中でロジックを書かずに書き出す
 */
struct ExtractingLogicView: View {
    var body: some View {
        VStack(spacing: 10) {
            ForEach(0..<15) { number in
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue)
                    .frame(width: getWidth(for: number),
                           height: getHight(for: number))
            }
        }
    }
}

private extension ExtractingLogicView {
    func getWidth(for number: Int) -> CGFloat {
        return CGFloat(number * 10)
    }

    func getHight(for number: Int) -> CGFloat {
        return CGFloat(number * 5)
    }
}

struct ExtractingLogicView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractingLogicView()
    }
}
