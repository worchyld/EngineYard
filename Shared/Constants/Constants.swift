
//
//  Constants.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2016 Amarjit. All rights reserved.
//

import Foundation

// Game constants from manual
struct Constants {
    fileprivate static var _cashGoal: Int = 300

    static let cashGoal: Int = {
        return (Tax.addSalesTax(toBalance: _cashGoal))
    }()

    public static func hasReachedGoal(cash: Int) -> Bool {
        return (cash >= Constants.cashGoal)
    }

    static let taxRate: Float = 0.10 // Players pay 10% of their cash in taxes, rounded down

    struct SeedCash {
        static let threePlayers: Int = 12
        static let fivePlayers: Int = 14
    }

    struct NumberOfPlayers {
        static let min: Int = 3
        static let max: Int = 5

        static func isValid(count:Int) throws -> Bool {
            guard ((Constants.NumberOfPlayers.min ... Constants.NumberOfPlayers.max).contains(count)) else {
                throw ErrorCode.invalidNumberOfPlayers
            }
            return true
        }
    }

    struct Board {
        static let decks: Int = 14 // total number of train decks
        static let cards: Int = 43 // total number of engine cards
        static let totalCapacity: Int = 46 // total capacity of all trains

        // There are 43 engine cards:
        // 20 green, 13 red, 7 yellow, 3 blue
        static func numberOfCardsForColor(engineColor: EngineColor) -> Int {
            switch engineColor {
            case .green:
                return 20
            case .red:
                return 13
            case .yellow:
                return 7
            case .blue:
                return 3
            }
        }

        // There are 14 decks, the makeup of the decks is:
        // 5 green, 4 red, 3 yellow, 2 blue
        static func numberOfDecksForColor(color: EngineColor) -> Int {
            switch color {
            case .green:
                return 5
            case .red:
                return 4
            case .yellow:
                return 3
            case .blue:
                return 2
            }
        }
    }
}

