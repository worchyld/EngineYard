//
//  FactoryProductionTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 28/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class FactoryProductionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProductionDidInit() throws {
        let fp = FactoryProduction(id: UUID(), units: 1)
        XCTAssertEqual(fp.units, 1)
        XCTAssertEqual(fp.spent, 0)
    }

    func testProductionCannotSpendZero() throws {
        let fp = FactoryProduction(id: UUID(), units: 1)
        let handler = ProductionHandler()
        let train = Fixtures.fakeTrain
        let player = Player.init(name: "Bob", cash: 1, avatar: "avt-1.png")

        let amount = 0

        XCTAssertThrowsError( try handler.increase(amount: amount, on: fp, train: train, player: player)) { error in
            //XCTAssertEqual(error as! SpendingError, SpendingError.notEnoughFunds(amount) )
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testProductionCannotSpendNegative() throws {
        let fp = FactoryProduction(id: UUID(), units: 1)
        let handler = ProductionHandler()
        let train = Fixtures.fakeTrain
        let player = Player.init(name: "Bob", cash: 1, avatar: "avt-1.png")

        let amount = -1

        XCTAssertThrowsError( try handler.increase(amount: amount, on: fp, train: train, player: player)) { error in
            //XCTAssertEqual(error as! SpendingError, SpendingError.notEnoughFunds(amount) )
            XCTAssertEqual(error as! SpendingError, SpendingError.mustBePositive(amount) )
        }
    }

    func testDontOwnThisCard() throws {
        let fp = FactoryProduction(id: UUID(), units: 1)
        let handler = ProductionHandler()
        let train = Fixtures.fakeTrain
        let player = Player.init(name: "Bob", cash: 1, avatar: "avt-1.png")

        let amount = 1

        XCTAssertThrowsError( try handler.increase(amount: amount, on: fp, train: train, player: player)) { error in
            //XCTAssertEqual(error as! SpendingError, SpendingError.notEnoughFunds(amount) )
            XCTAssertEqual(error.localizedDescription , "You don't own this card")
        }
    }

    func testDontHaveEnoughCash() throws {
        let fp = FactoryProduction(id: UUID(), units: 1)
        let handler = ProductionHandler()
        let train = Fixtures.fakeTrain
        let player = Player.init(name: "Bob", cash: 1, avatar: "avt-1.png")

        let amount = 1
        
        XCTAssertThrowsError( try handler.increase(amount: amount, on: fp, train: train, player: player)) { error in
            XCTAssertEqual(error as! SpendingError, SpendingError.notEnoughFunds(amount) )
        }
    }
}
