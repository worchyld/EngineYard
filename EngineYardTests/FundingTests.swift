//
//  FundingTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 06/10/2022.
//

import XCTest
@testable import EngineYard

final class FundingTests: XCTestCase {

    func testDidAddCreditOf1() throws {
        Funds.credit(balance: 0, with: 1)
    }

}
