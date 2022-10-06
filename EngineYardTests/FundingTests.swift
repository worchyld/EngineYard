//
//  FundingTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 06/10/2022.
//

import XCTest
@testable import EngineYard

final class FundingTests: XCTestCase {

    // MARK: Credit tests
    
    func testDidAddCreditOf1() throws {
        let result = Funds.credit(balance: 0, with: 1)

        guard case .success(let value) = result else {
            return XCTFail("Expected to be a success but got a failure with \(result)")
        }

        XCTAssertEqual(value, 1)
    }
    
    func testCannotCreditZero() throws {
        let result = Funds.credit(balance: 0, with: 0)
        
        switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure(let error):
                XCTAssertEqual(error, FundingError.mustBePositive)
            }
    }
    
    func testCannotCreditBelowZero() throws {
        let result = Funds.credit(balance: 0, with: -1)
        
        switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure(let error):
                XCTAssertEqual(error, FundingError.mustBePositive)
            }
    }
    
    // MARK: Debit tests
    
    func testDidDebit1Coin() throws {
        let result = Funds.debit(balance: 1, by: 1)

        guard case .success(let value) = result else {
            return XCTFail("Expected to be a success but got a failure with \(result)")
        }

        XCTAssertEqual(value, 0)
    }
    
    func testCannotDebitZero() throws {
        let result = Funds.debit(balance: 1, by: 0)

        switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure(let error):
                XCTAssertEqual(error, FundingError.mustBePositive)
            }
    }
    
    func testCannotDebitLessThanZero() throws {
        let result = Funds.debit(balance: 1, by: -1)

        switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure(let error):
                XCTAssertEqual(error, FundingError.mustBePositive)
            }
    }
    
    func testNotEnoughFunds() throws {
        let result = Funds.debit(balance: 3, by: 5)

        switch result {
            case .success(let value):
                XCTFail("Expected to be a failure but got a success with \(value)")
            case .failure(let error):
                XCTAssertEqual(error, FundingError.notEnough(funds: 3))
            }
    }
}
