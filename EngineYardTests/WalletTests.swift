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

        do {
            let _ = try wallet.credit(account: player, amount: amount)
            XCTFail("Wallet succeeded, but was expected to fail.")
        } catch let error as GameError<SpendingMoneyErrorReason> {
            XCTAssertEqual(error.reason, SpendingMoneyErrorReason.mustBePositive)
        }
        catch {
            XCTFail("Error caught: \(error)")
        }
    }

    func testWallet_DebitZero_Fails() throws {
        let wallet = Wallet()
        let amount = 0

        // When wallet is 0, Fail when debiting 0

        do {
            let _ = try wallet.debit(account: player, amount: amount)
            XCTFail("Wallet succeeded, but was expected to fail.")
        } catch let error as GameError<SpendingMoneyErrorReason> {
            XCTAssertEqual(error.reason, SpendingMoneyErrorReason.mustBePositive)
        }
        catch {
            XCTFail("Error caught: \(error)")
        }
    }

    func testWallet_DebitNegative_Fails() throws {
        let wallet = Wallet()
        let amount = -1

        do {
            let _ = try wallet.debit(account: player, amount: amount)
            XCTFail("Wallet succeeded, but was expected to fail.")
        } catch let error as GameError<SpendingMoneyErrorReason> {
            XCTAssertEqual(error.reason, SpendingMoneyErrorReason.mustBePositive)
        }
        catch {
            XCTFail("Error caught: \(error)")
        }

    }

    func testWallet_DebitNegative_WhenWalletIsPositive_Fails() throws {
        let wallet = Wallet()
        let anotherFakePlayer = FakePlayer(cash: 1)
        let amount = -1

        do {
            let _ = try wallet.credit(account: anotherFakePlayer, amount: amount)
            XCTFail("Wallet succeeded, but was expected to fail.")
        } catch let error as GameError<SpendingMoneyErrorReason> {
            XCTAssertEqual(error.reason, SpendingMoneyErrorReason.mustBePositive)
        }
        catch {
            XCTFail("Error caught: \(error)")
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
        let credit = 5
        let debit = 10

        XCTAssertNoThrow( try wallet.credit(account: player, amount: credit)  )

        do {
            let _ = try wallet.debit(account: player, amount: debit)
            XCTFail("Wallet succeeded, but was expected to fail.")
        } catch let error as GameError<SpendingMoneyErrorReason> {
            XCTAssertEqual(error.reason, SpendingMoneyErrorReason.notEnoughFunds(amount: debit))
        }
        catch {
            XCTFail("Error caught: \(error)")
        }

        XCTAssertEqual(player.cash, credit)
    }
}
