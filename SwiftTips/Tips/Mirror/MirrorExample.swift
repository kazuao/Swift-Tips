//
//  MirrorExample.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2023/05/09.
//

import Foundation

fileprivate struct Record {
    var locked: Bool = false
    var name1: String
    var name2: String
    var name3: String
    var name4: String
    var name5: String
    var updated_at: Date = Date()
}

extension Record {
    var isValid: Bool {
        let mirror = Mirror(reflecting: self)
        return mirror.children
            .compactMap { $0.value as? String }
            .allSatisfy { !$0.isBlank }
    }
}

extension String {
    public var isBlank: Bool {
        allSatisfy { $0.isWhitespace }
    }
}

fileprivate class MirrorExample {

    func example() {
        let record = Record(name1: "aaa", name2: "bbb", name3: "ccc", name4: "ddd", name5: "eee")
        let mirror = Mirror(reflecting: record)

        for child in mirror.children {
            let label = child.label ?? "-"
            print("\(label) \(child.value)")
            /*
             locked false
             name1 aaa
             name2 bbb
             name3 ccc
             name4 ddd
             name5 eee
             updated_at 2023-04-24 14:54:57 +0000
             */
        }
    }

    func example2() {
        let record = Record(name1: "aaa", name2: "bbb", name3: "ccc", name4: "ddd", name5: "eee")
        print(record.isValid) // true

        let record2 = Record(name1: "aaa", name2: " ", name3: "ccc", name4: "ddd", name5: "eee")
        print(record2.isValid) // false
    }
}

// Unit Testing
func testNormalizeStrings() {
    let record = Record(name1: " xyz", name2: "xyz ", name3: " xyz ", name4: "  xyz", name5: "xyz  ")
    let normal = record.normalize()

    let mirror = Mirror(reflecting: normal)
    mirror.children.forEach { child in
        if let value = child.value as? String {
//            XCTAssertEqual(value, "xyz")
        }
    }
}

extension Record {
    // ホワイトスペースを削除したり
    func normalize() -> Self {
        return self
    }
}
