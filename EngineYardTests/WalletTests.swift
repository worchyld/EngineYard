//
//  WalletTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class WalletTests: EngineYardTests {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCanDebit() {
        let balance = 100
        let amount = 10

        let w = Wallet()

        do {
            guard let result = try w.debit(balance: balance, amount: amount) else {
                return
            }
            print (String(result))
        } catch {
            print(error)
        }
    }

}
