//
//  MD5HashGeneratorTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class MD5HashGeneratorTests: XCTestCase {

    func test_hash_createsCorrectResult() {
        let sut = MD5HashGenerator()
        XCTAssertEqual(sut.hash(""), "")
        XCTAssertEqual(sut.hash("a"), "0cc175b9c0f1b6a831c399e269772661")
        XCTAssertEqual(sut.hash("b"), "92eb5ffee6ae2fec3ad71c777531578f")
        XCTAssertEqual(sut.hash("c"), "4a8a08f09d37b73795649038408b5f33")
        XCTAssertEqual(sut.hash("a test"), "2e03b237b4cd416b390b0a7150ac8029")
    }
}
