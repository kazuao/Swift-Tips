//
//  DebugPrinter.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/06/21.
//

import Foundation

@resultBuilder
public struct DebugPrinter {
    public static func buildBlock<T: CustomDebugStringConvertible>(
        _ component: T,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) -> T {
        print(file, function, line, component.debugDescription)
        return component
    }
}

struct DebugUtil {
    static func debugPrinter( _ error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        let fileName = file.components(separatedBy: "/").last!
        print("‼️‼️ " + fileName, function, line, error)
    }
}
