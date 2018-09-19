//
//  EngineYardTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest
@testable import EngineYard


extension Mock {

    struct Cards {
        var green: Int = 0
        var red: Int = 0
        var blue: Int = 0
        var yellow: Int = 0
        var total : Int {
            return (self.green + self.red + self.blue + self.yellow)
        }

        struct Expected {
            static let green = Rules.Board.numberOfCardsForColor(engineColor: .green)
            static let red = Rules.Board.numberOfCardsForColor(engineColor: .red)
            static let blue = Rules.Board.numberOfCardsForColor(engineColor: .blue)
            static let yellow = Rules.Board.numberOfCardsForColor(engineColor: .yellow)
            static let total = Rules.Board.cards
        }
    }
}



class EngineYardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func prepare() -> Board? {
        let players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return nil
        }
        guard let board = game.board else {
            XCTFail("Board object not initialised")
            return nil
        }
        return board
    }

}
