//
//  Bool+.swift
//  SwiftTips
//
//  Created by Kazunori Aoki on 2024/04/12.
//

import Foundation

/*
 Boolを反転する

 dialogSuppressionToggle(
   isSuppressed: $appSettings.confirmDelete.inverted)
 )
*/
extension Bool {
    var inverted: Self {
        get { !self }
        set { self = !newValue }
    }
}

