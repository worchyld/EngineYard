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

    func testNumberOfTrains_Equals14() throws {
        XCTAssertNotNil(response.trains)
        guard let trains = response.trains else {
            XCTFail("No trains")
            return
        }

        XCTAssertEqual(trains.count, meta.totalDecks)
    }

    func testEveryTrainCostIsAModulusOf4() throws {
        guard let trains = response.trains else {
            XCTFail("No trains")
            return
        }
        let _ = trains.map {  XCTAssertEqual( ($0.cost % 4), 0) }
    }

    func testTotalCapacityMeetsMetaExpectation() throws {
        guard let trains = response.trains else {
            XCTFail("No trains")
            return
        }
        let total = trains.reduce(0, { $0 + $1.maxDice } )
        XCTAssertEqual(total, meta.totalCapacity)
    }

    func testNumberOfCards_EqualsMetaExpectations() {
        guard let trains = response.trains else {
            XCTFail("No trains")
            return
        }
        let totalTrainPool = trains.reduce(0, { $0 + $1.trainPool } )
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

    func testBoardHasNilOrdersAndEmptyArrays() throws {
        let bundle = Bundle(for: type(of: self))
        let trainGame = TrainGame()

        try trainGame.start(bundle)

        XCTAssertNotNil(trainGame.board)
        guard let board =  trainGame.board else {
            XCTFail("Board doesn't exist")
            return
        }

        let _ = board.map { XCTAssertNotNil($0?.factoryProduction) }
        let _ = board.map { XCTAssertNotNil($0?.existingOrders) }
        let _ = board.map { XCTAssertNotNil($0?.completedOrders) }
        let _ = board.map { XCTAssertNil($0?.initialOrder) }
    }

    func testTrainsHaveProductionCostAndIncome() throws {
        let bundle = Bundle(for: type(of: self))
        let trainGame = TrainGame()

        try trainGame.start(bundle)

        XCTAssertNotNil(trainGame.board)
        guard let board =  trainGame.board else {
            XCTFail("Board doesn't exist")
            return
        }

        let _ = board.compactMap { $0.flatMap {
            XCTAssertEqual( $0.cost % 4, 0 )
            XCTAssertEqual( $0.productionCost, Int($0.cost / 2) )
            XCTAssertEqual( $0.income, Int($0.productionCost / 2) )
        } }
    }

}
