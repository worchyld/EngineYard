//
//  EngineYardTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest
@testable import EngineYard

struct Mock {
    public static func players(howMany: Int) -> [Player] {
        var players: [Player] = [Player]()

        do {
            if try Rules.NumberOfPlayers.isValid(count: howMany)
            {
                for index in stride(from:0, to: howMany, by: 1) {
                    let playerObj = Player(name: "Player #\(index)")
                    players.append(playerObj)
                }

                return players
            }
            else {
                assertionFailure("number of players is invalid: \(howMany)")
            }

        } catch let error {
            print ("Player setup error: \(error.localizedDescription as Any)")
        }

        return players
    }

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
}
