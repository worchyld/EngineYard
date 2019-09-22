//
//  Rules.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

struct Constants {
    public static let taxRate: Float = 0.10  // Players pay 10% of their cash in taxes, rounded down
    public static let endGameCashTrigger: Int = 330 // Game ends when a player hits 330 coins or more

    public struct NumberOfPlayers {
        public static let min: Int = 3
        public static let max: Int = 5

        public static func valid(_ numberOfPlayers: Int) throws -> Bool {
            guard ((Constants.NumberOfPlayers.min ... Constants.NumberOfPlayers.max).contains(numberOfPlayers)) else {
                throw ErrorCode.invalidNumberOfPlayers
            }
            return true
        }
    }
}

struct Seed {
    private static let threePlayerSeedCash: Int = 12
    private static let fivePlayerSeedCash: Int = 14

    static func cash(numberOfPlayers: Int) -> Int? {
        switch numberOfPlayers {
        case 3:
            return threePlayerSeedCash
        case 4, 5:
            return fivePlayerSeedCash
        default:
            return nil
        }
    }
}

struct Meta {
    static let totalDecks: Int = 14 // total number of decks
    static let totalCards: Int = 43 // total number of cards
    static let totalCapacity: Int = 46 // total capacity of all trains

    // There are 43 engine cards:
    // 20 green, 13 red, 7 yellow, 3 blue
    static func numberOfCards(with color: Deck.Color) -> Int {
        switch color {
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
    static func numberOfDecks(with color: Deck.Color) -> Int {
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
