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

    internal class FakePlayer: WalletHolderDelegate {
        var cash: Int

        init(cash: Int = 0) {
            self.cash = cash
        }
    }
    var player: FakePlayer!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.player = FakePlayer()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWallet_DidCredit10Coins() throws {
        let wallet = Wallet()
        let amount = 10

        XCTAssertNoThrow( try wallet.credit(account: player, amount: amount) )
        XCTAssertEqual(player.cash, amount )
    }


    func testWallet_CreditZero_Fails() throws {
        let wallet = Wallet()
        let amount = 0

        XCTAssertThrowsError(try wallet.credit(account: player, amount: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testWallet_DebitZero_Fails() throws {
        let wallet = Wallet()
        let amount = 0

        // When wallet is 0, Fail when debiting 0
        XCTAssertThrowsError(try wallet.debit(account: player, amount: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.notEnoughFunds(amount) )
        }
    }

    func testWallet_DebitNegative_Fails() throws {
        let wallet = Wallet()
        let amount = -1

        // Expect not enough funds Wallet has 0 cash
        XCTAssertThrowsError(try wallet.debit(account: player, amount: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.notEnoughFunds(0) )
        }
    }

    func testWallet_DebitNegative_WhenWalletIsPositive_Fails() throws {
        let wallet = Wallet()
        let anotherFakePlayer = FakePlayer(cash: 1)
        let amount = -1

        // Expect throw must be positive
        XCTAssertThrowsError(try wallet.debit(account: anotherFakePlayer, amount: amount) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testWallet_DebitEqualsZero() throws {
        let wallet = Wallet()

        let amount = 5
        let debit = 5
        let expected = 0

        XCTAssertNoThrow( try wallet.credit(account: player, amount: amount)  )
        XCTAssertNoThrow( try wallet.debit(account: player, amount: debit) )
        XCTAssertEqual( player.cash  , expected)
    }


    func testWallet_DebitMoreThanFunds_Fails() throws {
        let wallet = Wallet()

        // Try to debit more than amount - expect fail
        let amount = 5
        let debit = 10

        XCTAssertNoThrow( try wallet.credit(account: player, amount: amount)  )

        XCTAssertThrowsError(try wallet.debit(account: player, amount: debit) ) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.cannotSpend(debit) )
        }

        XCTAssertEqual(player.cash, amount)
    }
}
