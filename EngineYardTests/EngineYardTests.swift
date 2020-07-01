//
//  EngineYardTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest
@testable import EngineYard

class EngineYardTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    public func performTest(closure: () throws -> Void) {
           do {
               try closure()
           } catch {
               XCTFail("Unexpected error thrown: \(error)")
           }
       }

    public func assert<T, E: Error>(_ expression: @autoclosure () throws -> T,
                                     throwsErrorOfType expectedError: E.Type) {
        do {
            _ = try expression()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is E)
        }
    }

    
}

