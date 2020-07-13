//
//  BoardCreationTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 27/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class BoardCreationTests: XCTestCase {

    var response: Response!
    var meta: Meta!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.meta = Meta.build()

        let bundle = Bundle(for: type(of: self))
        let file = Constants.boardJSONFile
        let api = DataLoader.shared
        let result = api.load(from: bundle, file: file)

        switch result {
        case .success(let response):
            self.response = response

        case .failure(let error):
            throw(error)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testNumberOfFactories_Equals14() {
        XCTAssertNotNil(response.factories)
        guard let factories = response.factories else {
            XCTFail("No factories")
            return
        }
        XCTAssertEqual(factories.count, meta.totalDecks)
    }


    func testEveryTrainCostIsAModulusOf4() throws {
        guard let factories = response.factories else {
            XCTFail("No factories")
            return
        }
        let _ = factories.map {  XCTAssertEqual( ($0.cost % 4), 0) }
    }

    func testTotalCapacityMeetsMetaExpectation() throws {
        guard let factories = response.factories else {
            XCTFail("No factories")
            return
        }
        let total = factories.reduce(0, { $0 + $1.maxDice } )
        XCTAssertEqual(total, meta.totalCapacity)
    }

    func testNumberOfCards_EqualsMetaExpectations() {
        guard let factories = response.factories else {
            XCTFail("No factories")
            return
        }
        let totalTrainPool = factories.reduce(0, { $0 + $1.trainPool } )
        XCTAssertEqual( totalTrainPool , meta.cards.total )
    }


    func testBoardGetsConstructed() throws {
        let bundle = Bundle(for: type(of: self))
        let trainGame = TrainGame()

        try trainGame.start(bundle)

        XCTAssertNotNil(trainGame.board)
        guard let board =  trainGame.board else {
            XCTFail("Board doesn't exist")
            return
        }
        XCTAssertEqual(board.count, meta.totalDecks)
    }

    func testBoardHasFactories() throws {
        let bundle = Bundle(for: type(of: self))
        let trainGame = TrainGame()

        try trainGame.start(bundle)

        for item in trainGame.board {
            XCTAssertNotNil(item)
        }
        XCTAssertEqual(trainGame.board.count, 14)
    }

    func testBoardHasNoOrders() throws {
        let bundle = Bundle(for: type(of: self))
        let trainGame = TrainGame()

        try trainGame.start(bundle)

        XCTAssertNotNil(trainGame.board)
        guard let board =  trainGame.board else {
            XCTFail("Board doesn't exist")
            return
        }

        let _ = board.compactMap { XCTAssertNil($0?.existingOrders) }
        let _ = board.compactMap { XCTAssertNil($0?.completedOrders) }
        let _ = board.compactMap { XCTAssertNil($0?.initialOrder) }

        let _ = board.map {
            guard let item = $0 else {
                XCTFail("No factory found")
                return
            }
            XCTAssertEqual( item.summarizedOrders.count , 0)

            // Check modulus'
            XCTAssertEqual( item.cost % 4, 0 )
            XCTAssertEqual( item.productionCost, Int(item.cost / 2) )
            XCTAssertEqual( item.income, Int(item.productionCost / 2) )
        }
    }

}
