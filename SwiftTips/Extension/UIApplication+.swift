//
//  UIApplication+.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/16.
//

import UIKit

extension UIApplication {
    // キーボードを消す
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
