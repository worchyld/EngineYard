//
//  WalletTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class WalletTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCredit() {
        let w: Wallet = Wallet()

        XCTAssertThrowsError(try w.credit(amount: -100)) { error in
            XCTAssertEqual(error as? WalletError, WalletError.mustBePositive)
        }

        XCTAssertTrue(w.balance == 0)
    }

    
}
