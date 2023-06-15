//
//  RustingTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 15/06/2023.
//

import XCTest

@testable import EngineYard

final class RustingTests: XCTestCase {

    // case notBuilt, hasInitialOrder, new, rusting, rusted
    func testRustWasSetToHasInitialOrder() {
           var rust = Rust.notBuilt
           let expected = Rust.hasInitialOrder
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
