//
//  WalletTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
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


    func testWallet_SpendZero_Fails() {
        let wallet = Wallet.init(100)
        var debitor = WalletSpendingInteractor(wallet: wallet)

        let spend = 0

        XCTAssertThrowsError(try debitor.debit(amount: spend) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(spend) )
        }

        XCTAssertTrue(wallet.cash == 100)
    }


    func testWallet_SpendNegative_Fails() {
        let wallet = Wallet.init(100)
        var debitor = WalletSpendingInteractor(wallet: wallet)

        let spend = -1

        XCTAssertThrowsError(try debitor.debit(amount: spend) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(spend) )
        }
    }

    // Cannot go negative
    func testWallet_SpendMoreThanCashOnHand_Fails() {
        let wallet = Wallet.init(100)
        var debitor = WalletSpendingInteractor(wallet: wallet)

        let spend = 101
        XCTAssertThrowsError(try debitor.debit(amount: spend) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.notEnoughFunds(spend) )
        }
    }

    func testWallet_DidSpend10Coins() {
        let wallet = Wallet.init(100)
        var debitor = WalletSpendingInteractor(wallet: wallet)

        let spend = 10

        XCTAssertNoThrow( try debitor.debit(amount: spend) )
        XCTAssertTrue(wallet.cash == 90)
    }
}
