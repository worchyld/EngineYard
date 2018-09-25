//
//  SalesTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class SalesTests: EngineYardTests {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSingleSaleBook() {
        let sb: SalesBook = SalesBook()

        let sale = Sale(units: 100, price: 10)

        sb.add(sale: sale)

        XCTAssertTrue(sb.total == (100 * 10) )
    }

    func testMultipleSalesBook() {

        let sb: SalesBook = SalesBook()

        let sales = [ Sale(units: 100, price: 10),
                      Sale(units: 100, price: 10),
                      Sale(units: 100, price: 10)
        ]

        sales.forEach{ sb.add(sale: $0) }

        XCTAssertTrue(sb.total == ((100 * 10) * sales.count) )
    }

    func testWithSingleProduct() {
        guard let game:Game = (Game.setup(with: Mock.players(howMany: 5))) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }

        guard let player = game.players?.first as? Player else {
            print ("No player found")
            return
        }

        firstDeck.orderBook.clear()

        firstDeck.orderBook.add(.existingOrder, values: [3])
        XCTAssertTrue(firstDeck.orderBook.existingOrderValues.first == 3)

        guard let firstOrder = firstDeck.orderBook.existingOrders.first else {
            return
        }

        let sale = Sale(product: firstDeck, units: firstOrder.value, price: firstDeck.income)
        player.salesBook.add(sale: sale)

        XCTAssertTrue(player.salesBook.sales.count == 1, "\(player.salesBook.sales.count)")
        XCTAssertTrue(player.salesBook.total == (3 * firstDeck.income) )
    }

    func testWithMultipleSales() {
        guard let game:Game = (Game.setup(with: Mock.players(howMany: 5))) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return
        }
        guard let firstDeck = board.decks.first else {
            XCTFail("No first deck found")
            return
        }

        guard let player = game.players?.first as? Player else {
            print ("No player found")
            return
        }

        firstDeck.orderBook.clear()

        firstDeck.orderBook.add(.existingOrder, values: [3, 5, 2])
        XCTAssertTrue(firstDeck.orderBook.existingOrderValues.first == 3)

        for order in firstDeck.orderBook.existingOrders {

            let sale = Sale(product: firstDeck, units: order.value, price: firstDeck.income)
            player.salesBook.add(sale: sale)
        }

        XCTAssertTrue(player.salesBook.sales.count == 3)
        XCTAssertTrue(player.salesBook.total == ((3 + 5 + 2) * firstDeck.income) )
    }

}
