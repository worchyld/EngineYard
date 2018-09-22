//
//  SalesTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 05/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class SalesTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerfectMatch() {
        let units = 3
        let orders = [3]

        let handler = SalesCaseHandler(card: nil, units, orders)
        handler.analyse()

        XCTAssertTrue(handler.orders.first! == 0)
        XCTAssertTrue(handler.units == 0)
    }

    func testLowerMatch() {
        let units = 1
        let orders = [6]

        let handler = SalesCaseHandler(card: nil, units, orders)
        handler.analyse()

        let remainingUnits = (orders.first! - units)

        XCTAssertTrue(handler.units == 0)
        XCTAssertTrue(handler.orders.first! == remainingUnits)
    }

    func testHigherMatch() {
        let units: Int = 5
        let orders: [Int] = [4]

        /*
        let unitsSold: Int = {
            return orders.first! as Int
        }()*/

        let handler = SalesCaseHandler(card: nil, units, orders)
        handler.analyse()

        let expectedOrders : Int = {
            var order:Int = orders.first! as Int
            order -= order
            return order
        }()

        XCTAssertTrue(handler.orders.first! == expectedOrders, "\(handler.orders.first!) vs \(expectedOrders)")
    }

    func testMixedSaleLower() {
        let units: Int = 4
        let orders: [Int] = [3,5,2]

        let handler = SalesCaseHandler(card: nil, units, orders)
        handler.analyse()

        XCTAssertTrue(handler.ruleMatched == SalesCaseType.lowerMatch)

        XCTAssertTrue(handler.orders == [3,1,2])
        //XCTAssertTrue(handler.unitsSold == 4)
        XCTAssertTrue(handler.units == 0)
    }

    func testMixedPerfect() {
        let units: Int = 6
        let orders: [Int] = [3,6,2]

        let handler = SalesCaseHandler(card: nil, units, orders)
        handler.analyse()

        XCTAssertTrue(handler.ruleMatched == SalesCaseType.perfectMatch)
        XCTAssertTrue(handler.orders == [3,0,2], "\(handler.orders)")
        //XCTAssertTrue(handler.unitsSold == 6, "\(handler.unitsSold)")
        XCTAssertTrue(handler.units == 0, "\(handler.units)")
    }

    func testMixedSaleHigher() {
        let units: Int = 6
        let orders: [Int] = [3,5,2]

        let handler = SalesCaseHandler(card: nil, units, orders)
        handler.analyse()

        XCTAssertTrue(handler.ruleMatched == SalesCaseType.higherMatch)

        XCTAssertTrue(handler.orders == [3,0,2], "\(handler.orders)")
        //XCTAssertTrue(handler.unitsSold == 5, "\(handler.unitsSold)")
        XCTAssertTrue(handler.units == 1, "\(handler.units)")
    }

    func testMixedSaleReallyHigh() {
        let units: Int = 9
        let orders: [Int] = [3,5,2]

        let handler = SalesCaseHandler(card: nil, units, orders)
        handler.analyse()

        XCTAssertTrue(handler.ruleMatched == SalesCaseType.higherMatch)
        XCTAssertTrue(handler.orders == [3,0,2], "\(handler.orders)")
        //XCTAssertTrue(handler.unitsSold == 5, "\(handler.unitsSold)")
        XCTAssertTrue(handler.units == (9-5), "\(handler.units)")
    }

    func testSalesLoop() {
        var units: Int = 1
        var orders: [Int] = [12,1,1]

        let handler = SalesCaseHandler(card: nil, units, orders)
        handler.salesLoop()
        units = handler.units
        orders = handler.orders

        XCTAssertTrue(units == 0)
        XCTAssertTrue(orders == [12,0,1])

        print ("units: \(units)")
        print ("orders: \(orders)")
    }

    
    func testPlayerExpectedSales() {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstPlayer = players.first else {
            XCTFail("No first player found")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }
        XCTAssertTrue(firstDeck.owners?.count == 0)
        XCTAssertTrue(firstPlayer.hand.cards.count == 0)

        // Find the first unowned card in the deck?
        guard let firstCard = firstDeck.findFirstUnownedCard() else {
            XCTFail("No unowned card found")
            return
        }

        do {
            try firstPlayer.hand.add(firstCard)
        } catch let error {
            XCTFail(error.localizedDescription as String)
        }

        XCTAssertTrue(firstCard.production.units == 1)
        XCTAssertTrue(firstPlayer.hand.cards.count == 1)
        XCTAssertTrue(firstCard.owner == firstPlayer)
        XCTAssertTrue(firstDeck.owners?.count == 1)
        XCTAssertTrue(firstDeck.owners?.first == firstPlayer)


        let orders: [Int] = firstDeck.orderBook.existingOrderValues
        let units: Int = firstCard.production.units

        let handler = SalesCaseHandler(card: firstCard, units, orders)
        handler.salesLoop()

        XCTAssertTrue(handler.salesBook.total > 0)
        print (handler.salesBook.total)


    }

}
