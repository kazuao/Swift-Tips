//
//  PrivatePublicatable.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/07/05.
//

import Foundation

// ref: https://qiita.com/takasek/items/d1f11394b6df2f3f3cc0

/// fileprivateな変数、関数をテストするためのインターフェース
public protocol PrivatePublicatable {
    associatedtype Publicater
    var `private`: Publicater { get }
}

public final class Private<Base> {
    public let base: Base
    public init(_ base: Base) { self.base = base }
}

public extension PrivatePublicatable {
    var `private`: Private<Self> { return Private(self) }
}

// MARK: こんなものを対象のclass/structに生やす
//extension <# target #>: PrivatePublicatable {}
//extension Private where Base == <# target #> {
//    <# variable #>
//
//    <# function #>
//}


/* 以下サンプル */
struct Hoge {
    // ファイル内からアクセスする必要があるので、fileprivateにする必要がある
    fileprivate let x: Int
    init(x: Int) {
        self.x = x
    }

    fileprivate func doSomething(with string: String) -> String {
        return "\(string): \(x)"
    }
}


// MARK: Extension
extension Hoge: PrivatePublicatable {}
extension Private where Base == Hoge {
    var x: Int { return base.x }

    func doSomething(with string: String) -> String {
        return base.doSomething(with: string)
    }
}

//class HogeTest {
//    func test_hoge() {
//        let n = 3
//        let s = "ほげ"
//
//        let hoge = Hoge(x: n)
//
//        XCTAssertEqual(hoge.private.x, n)
//        XCTAssertEqual(hoge.private.doSomething(with: s), "\(s): \(n)")
//    }
//}
