//
//  TrainHasOrdersTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 28/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TrainHasOrdersTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTrainHasNoOrders() {
        let train = Fixtures.fakeTrain
        XCTAssertFalse(train.hasOrders())
    }

    func testTrainHasOrders_InitialOrderIsPositive() {
        let train = Fixtures.fakeTrain
        XCTAssertNil(train.initialOrder)
        train.initialOrder = Die.roll
        XCTAssertNotNil(train.initialOrder)
        XCTAssertNil(train.existingOrders)
        XCTAssertNil(train.completedOrders)
        XCTAssertTrue(train.hasOrders())

    }

    func testTrainHasOrders_ExistingOrdersArePositive() {
        let train: Train = {
            return Train.init(id: UUID(),
                              name: "green-1", avatar: "green-1.png",
                              cost: 4, trainPool: 3,
                              livery: .green, generation: .first,
                              rusting: .new,
                              maxDice: 3, initialOrder: nil, existingOrders: [Int](), completedOrders: nil, factoryProduction: nil)
        }()

        XCTAssertNotNil(train.existingOrders)
        XCTAssertEqual(train.existingOrders?.isEmpty, true)

        train.existingOrders?.append( Die.roll )
        XCTAssertNil(train.initialOrder)
        XCTAssertNotNil(train.existingOrders)
        XCTAssertNil(train.completedOrders)
        XCTAssertTrue(train.hasOrders())

    }

    func testTrainHasOrders_CompletedOrdersArePositive() {
        let train: Train = {
            return Train.init(id: UUID(),
                              name: "green-1", avatar: "green-1.png",
                              cost: 4, trainPool: 3,
                              livery: .green, generation: .first,
                              rusting: .new,
                              maxDice: 3, initialOrder: nil, existingOrders:nil, completedOrders: [Int](), factoryProduction: nil)
        }()
        
        XCTAssertNotNil(train.completedOrders)
        train.completedOrders?.append( Die.roll )
        XCTAssertNotNil(train.completedOrders)

        XCTAssertNil(train.initialOrder)
        XCTAssertNil(train.existingOrders)

        XCTAssertTrue(train.hasOrders())
    }

    func testTrainCompactMapOrdersIsZero() {
        let train: Train = {
            return Train.init(id: UUID(),
                              name: "green-1", avatar: "green-1.png",
                              cost: 4, trainPool: 3,
                              livery: .green, generation: .first,
                              rusting: .new,
                              maxDice: 3, initialOrder: nil, existingOrders:nil, completedOrders: [Int](), factoryProduction: nil)
        }()

        var completedOrders: Int = train.initialOrder ?? 0
        completedOrders += train.existingOrders?.compactMap({ $0 }).reduce(0, +) ?? 0
        completedOrders += train.completedOrders?.compactMap({ $0 }).reduce(0, +) ?? 0

        XCTAssertEqual(completedOrders, 0)
    }

    func testTrainCompactMapOrdersIsOne() {
        let train: Train = {
            return Train.init(id: UUID(),
                              name: "green-1", avatar: "green-1.png",
                              cost: 4, trainPool: 3,
                              livery: .green, generation: .first,
                              rusting: .new,
                              maxDice: 3, initialOrder: 1, existingOrders:nil, completedOrders: [Int](), factoryProduction: nil)
        }()

        var completedOrders: Int = train.initialOrder ?? 0
        completedOrders += train.existingOrders?.compactMap({ $0 }).reduce(0, +) ?? 0
        completedOrders += train.completedOrders?.compactMap({ $0 }).reduce(0, +) ?? 0

        XCTAssertEqual(completedOrders, 1)
    }

    func testTrainCompactMapOrdersIsMixed() {
        let train: Train = {
            return Train.init(id: UUID(),
                              name: "green-1", avatar: "green-1.png",
                              cost: 4, trainPool: 3,
                              livery: .green, generation: .first,
                              rusting: .new,
                              maxDice: 3, initialOrder: 1, existingOrders:[3,5,7], completedOrders: nil, factoryProduction: nil)
        }()

        var completedOrders: Int = train.initialOrder ?? 0
        completedOrders += train.existingOrders?.compactMap({ $0 }).reduce(0, +) ?? 0
        completedOrders += train.completedOrders?.compactMap({ $0 }).reduce(0, +) ?? 0

        XCTAssertEqual(completedOrders, 16)
    }
}
