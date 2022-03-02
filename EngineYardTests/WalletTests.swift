//
//  WalletTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 02/03/2022.
//

import XCTest
@testable import EngineYard

class WalletTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanCreditPositiveAmount() throws {
        let w = Wallet()
        let result = w.credit(100)
        XCTAssert(result == true)
        XCTAssert(w.balance == 100)
    }
}
