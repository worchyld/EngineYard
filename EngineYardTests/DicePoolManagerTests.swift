//
//  DicePoolManagerTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 18/09/2022.
//

import XCTest

@testable import EngineYard

final class DicePoolManagerTests: XCTestCase {
    var board: Board?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.board = Board()
        self.board!.decks = self.board!.prepare()
    }

    func testCapacityIsEmpty() throws {
        let _ = self.board!.decks.map {
            XCTAssertTrue($0.dicePool.count == 0)
            XCTAssertTrue($0.maxDice > 0 && $0.maxDice <= 5)
        }
    }

    
    func testAddSingleD6ToDicePool() throws {
        let firstDeck: Deck = self.board!.decks.first! as Deck
        let manager = DicePoolManager.init(deck: firstDeck)
        XCTAssertNoThrow(try manager.addToDicePool())
        
        XCTAssertTrue(firstDeck.dicePool.count == 1)
        XCTAssertTrue(firstDeck.dicePool.count < firstDeck.maxDice)
    }
    
    
    func testFillDicePoolToCapacity() throws {
        let firstDeck: Deck = self.board!.decks.first! as Deck
        let manager = DicePoolManager.init(deck: firstDeck)
                
        for _ in 1...firstDeck.maxDice {
            XCTAssertNoThrow(try manager.addToDicePool())
        }
        XCTAssertTrue(firstDeck.dicePool.count == firstDeck.maxDice)
    }
    
    func testFillBeyondCapacityExpectError() throws {
        let firstDeck: Deck = self.board!.decks.first! as Deck
        let manager = DicePoolManager.init(deck: firstDeck)
        
        for _ in 1...firstDeck.maxDice {
            //firstDeck.addToDicePool(d6: D6())
            XCTAssertNoThrow(try manager.addToDicePool())
        }
        
        XCTAssertThrowsError(try manager.addToDicePool()) { error in
            XCTAssertEqual(error as? DicePoolError, DicePoolError.poolIsFull)
        }
    }
}
