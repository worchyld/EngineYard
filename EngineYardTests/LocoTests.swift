//
//  LocoTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 02/10/2022.
//

import XCTest

@testable import EngineYard

final class LocoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testLocoDidChange() throws {
        var l = Locomotive(4, .green, .first, 4)
        XCTAssertFalse(l.available)
        XCTAssertTrue(l.rusted == .notBuilt)
        
        l = l.execute(.obsolence(.new))
        XCTAssertFalse(l.available)
        XCTAssertTrue(l.rusted == .new)
    }

}
