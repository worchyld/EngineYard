//
//  RustTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 08/03/2022.
//

import XCTest

@testable import EngineYard

class RustTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRustNotBuiltToNew() {
        var rust = Rust.notBuilt
        let expected = Rust.new
        rust.age()
        XCTAssertEqual(rust, expected)
        print ("Rust: \(rust)")
    }
    
    func testRustingToRusted() {
        var rust = Rust.rusting
        let expected = Rust.rusted
        rust.age()
        XCTAssertEqual(rust, expected)
        print ("Rust: \(rust)")
    }
    
    
    /* needs fixing */
    func testRustedDoesNotLoop() {
        var rust = Rust.rusted
        let expected = Rust.rusted
        rust.age()
        XCTAssertEqual(rust, expected)
        print ("Rust: \(rust)")
    }

}
