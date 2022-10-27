//
//  BoardTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/10/2022.
//

import XCTest
@testable import EngineYard

final class BoardTests: XCTestCase {
    
    var board: Board?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        var game = Game()
        let gsm = GameSetupManager(game: game)
        do {
            game = try gsm.setup(for: [Player(), Player(), Player()])
            guard let board = game.board else {
                XCTFail("No game board")
                return
            }
            self.board = board
        } catch let err {
            XCTFail(err.localizedDescription)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBoardDidPrepare() throws {
        guard let board = self.board else {
            XCTFail("No board")
            return
        }

        XCTAssertTrue(board.decks.count == Constants.totalDecks, "Expected: \(Constants.totalDecks), Got: \(board.decks.count)")
        
        let totalCards = board.decks.map {
            return $0.cards.count
        }.reduce(0, +)
        
        XCTAssertTrue(totalCards == Constants.totalCards)
      
        let totalCapacity = board.decks.map {
            return $0.loco.capacity
        }.reduce(0, +)
        
        XCTAssertTrue(totalCapacity == Constants.totalCapacity)
        
        let greenGens = board.decks.filter {
            return $0.loco.livery == .green
        }
        let redGens = board.decks.filter {
            return $0.loco.livery == .red
        }
        let yellowGens = board.decks.filter {
            return $0.loco.livery == .yellow
        }
        let blueGens = board.decks.filter {
            return $0.loco.livery == .blue
        }
        
        XCTAssertTrue(greenGens.count == Constants.Green.totalGenerations, "got: \(greenGens)")
        XCTAssertTrue(redGens.count == Constants.Red.totalGenerations, "got: \(redGens)")
        XCTAssertTrue(yellowGens.count == Constants.Yellow.totalGenerations, "got: \(yellowGens)")
        XCTAssertTrue(blueGens.count == Constants.Blue.totalGenerations, "got: \(blueGens)")
        
        let greenCards = greenGens.map {
            return $0.cards.count
        }.reduce(0, +)
        let redCards = redGens.map {
            return $0.cards.count
        }.reduce(0, +)
        let yellowCards = yellowGens.map {
            return $0.cards.count
        }.reduce(0, +)
        let blueCards = blueGens.map {
            return $0.cards.count
        }.reduce(0, +)
        
        XCTAssertTrue(greenCards == Constants.Green.totalCards, "got: \(greenCards)")
        XCTAssertTrue(redCards == Constants.Red.totalCards, "got: \(redCards)")
        XCTAssertTrue(yellowCards == Constants.Yellow.totalCards, "got: \(yellowCards)")
        XCTAssertTrue(blueCards == Constants.Blue.totalCards, "got: \(blueCards)")
    }

}
