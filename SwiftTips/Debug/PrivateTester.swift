//
//  PrivateTester.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/07/05.
//

import Foundation

/// Privateなclass/structの場合、ファイル外から見えないため、ファイル内に以下を生やす
//final class <# target #>Tester<Base> {
//    private let base: Base
//    init(<# 注入したい変数 #>) {
//        base = <# target init #>
//    }
//
//    <# variable #>
//    <# function #>
//}


/* 以下サンプル */
private struct Fuga {
    let x: Int
    let y: Int

    func doSomething(with string: String) -> String {
        return "\(string): \(x), \(y)"
    }
}


// 同じファイルに書く必要がある
final class FugaTester {
    private let base: Fuga
    init(args: (x: Int, y: Int)) {
        base = Fuga(x: args.x, y: args.y)
    }

    var x: Int { return base.x }
    var y: Int { return base.y }

    func doSomething(with string: String) -> String {
        return base.doSomething(with: string)
    }
}

//private class FugaTest {
//    func test_fuga() {
//        let x = 1
//        let y = 2
//        let s = "ふが"
//
//        let tester = FugaTester(args: (x: x, y: y))
//
//        XCTAssertEqual(tester.x, x)
//        XCTAssertEqual(tester.y, y)
//        XCTAssertEqual(tester.doSomething(with: s), "\(s): \(x), \(y)")
//    }
//}
