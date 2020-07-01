//
//  TrainHasOrdersTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 28/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TrainHasOrdersTests: EngineYardTests {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTrainHasNoOrders() {
        let train = Fixtures.mockFactory
        XCTAssertNil(train.initialOrder)
        XCTAssertNil(train.existingOrders)
        XCTAssertNil(train.completedOrders)
        XCTAssertEqual(train.summarizedOrders.count, 0)
    }

    func testTrainHasOrders_InitialOrderIsPositive() {
        let train = Fixtures.mockFactory
        XCTAssertNil(train.initialOrder)

        let order = Die.roll
        train.initialOrder = order
        XCTAssertNotNil(train.initialOrder)

        XCTAssertNil(train.existingOrders)
        XCTAssertNil(train.completedOrders)

        XCTAssertEqual( train.summarizedOrders.count , 1)
    }

    func testFactory_HasExistingOrders() {
        let f: Factory = {
            return Factory.init(id: UUID(),
                                name: "green-1", avatar: "green-1.png", livery: .green, generation: .first, cost: 4, rust: .new,
                                cards: nil, maxDice: 4, trainPool: 3, initialOrder: nil, existingOrders: [3,5,2], completedOrders: nil)
        }()

        XCTAssertNil(f.initialOrder)
        XCTAssertNil(f.completedOrders)
        XCTAssertNotNil(f.existingOrders)
        XCTAssertEqual(f.existingOrders?.count, 3)
        XCTAssertEqual(f.summarizedOrders.count, 3, "Summarised orders: \(f.summarizedOrders)")
    }

    func testFactory_HasMixedOrders() {
        let f: Factory = {
            return Factory.init(id: UUID(),
                                name: "green-1", avatar: "green-1.png", livery: .green, generation: .first, cost: 4, rust: .new,
                                cards: nil, maxDice: 4, trainPool: 3, initialOrder: nil, existingOrders: [3,5,2], completedOrders: [6])
        }()

        XCTAssertNil(f.initialOrder)
        XCTAssertNotNil(f.completedOrders)
        XCTAssertNotNil(f.existingOrders)
        XCTAssertEqual(f.existingOrders?.count, 3)
        XCTAssertEqual(f.completedOrders?.count, 1)
        XCTAssertEqual(f.summarizedOrders.count, 4, "Summarised orders: \(f.summarizedOrders)")
    }

    func testFactoryIsNotAvailable() {
        let f: Factory = {
            return Factory.init(id: UUID(),
                                name: "green-1", avatar: "green-1.png", livery: .green, generation: .first, cost: 4, rust: .new,
                                cards: nil, maxDice: 4, trainPool: 3, initialOrder: nil, existingOrders: nil, completedOrders: nil)
        }()

        XCTAssertEqual( f.summarizedOrders.count , 0)
        XCTAssertEqual( f.isAvailable, false)
    }

    func testFactoryHasOrdersButRusted() {
        let f: Factory = {
            return Factory.init(id: UUID(),
                                name: "green-1", avatar: "green-1.png", livery: .green, generation: .first, cost: 4, rust: .rusted,
                                cards: nil, maxDice: 4, trainPool: 3, initialOrder: nil, existingOrders: [3,5,2], completedOrders: nil)
        }()

        XCTAssertEqual( f.summarizedOrders.count, 3)
        XCTAssertEqual( f.isAvailable, false)
        XCTAssertEqual( f.rust, Rust.rusted)
    }
}
