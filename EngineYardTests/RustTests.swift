//
//  RustTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 08/03/2022.
//

import XCTest

@testable import EngineYard

class RustTests: XCTestCase {

    func testRustNotBuiltToNew() {
        var rust = Rust.notBuilt
        let expected = Rust.new
        rust.rustify()
        XCTAssertEqual(rust, expected)
        print ("Rust: \(rust)")
    }
    
    func testRustingToRusted() {
        var rust = Rust.rusting
        let expected = Rust.rusted
        rust.rustify()
        XCTAssertEqual(rust, expected)
        print ("Rust: \(rust)")
    }
    
    
    func testRustedDoesNotLoop() {
        var rust = Rust.rusted
        let expected = Rust.rusted
        rust.rustify()
        XCTAssertEqual(rust, expected)
        XCTAssertNotEqual(rust, .notBuilt)
    }

}
