//
//  XCTAssertThrowsErrorAsync.swift
//  SwiftTipsTests
//
//  Created by kazunori.aoki on 2022/12/06.
//

import XCTest

func XCTAssertThrowsErrorAsync<T, R>(
    _ expression: @autoclosure () async throws -> T,
    _ errorThrown: @autoclosure () -> R,
    _ message: @autoclosure () -> String = "This method should fail",
    file: StaticString = #filePath,
    line: UInt = #line
) async where R: Comparable, R: Error {
    do {
        let _ = try await expression()
        XCTFail(message(), file: file, line: line)
    } catch {
        XCTAssertEqual(error as? R, errorThrown())
    }
}

// Usage
//func testIfMyCodeThrown() async throws {
//    await XCTAssertThrowsErrorAsync(try await myThrowingFunc(), Error.myExpectedError)
//}
