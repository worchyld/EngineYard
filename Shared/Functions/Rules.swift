//
//  Constants.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

enum RulesError : Error {
    case invalidNumberOfPlayers
    case invalidDeckSetup
    case invalidCardSetup
}

struct Rules {
    public static let goal: Int = 330
    public static let taxRate: Float = 0.10

    public static func isGameEndConditionMet(_ cash: Int) -> Bool {
        return (cash >= Rules.goal)
    }

    struct NumberOfPlayers {
        static let min: Int = 3
        static let max: Int = 5
        static let threePlayerSeedCash : Int = 12
        static let fivePlayerSeedCash : Int = 14

        static func isValid(count: Int) throws -> Bool {
            guard ((Rules.NumberOfPlayers.min ... Rules.NumberOfPlayers.max).contains(count)) else {
                throw RulesError.invalidNumberOfPlayers
            }
            return true
        }

        static func getSeedCash(forNumberOfPlayers players: Int) -> Int {
            switch players {
            case Rules.NumberOfPlayers.min:
                return Rules.NumberOfPlayers.threePlayerSeedCash
            default:
                return Rules.NumberOfPlayers.fivePlayerSeedCash
            }
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
