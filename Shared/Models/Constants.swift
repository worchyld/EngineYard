//
//  Rules.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

struct Constants {
    public static let endGameCashTrigger: Int = 330 // Game ends when a player hits 330 coins or more

    public struct SeedCash {
        public static let threePlayer: Int = 12
        public static let fivePlayer: Int = 14
    }

    public struct ValidNumberOfPlayers {
        public static let min: Int = 3
        public static let max: Int = 5

        static func isValid( _ numberOfPlayers: Int) -> Bool {
            let min = Constants.ValidNumberOfPlayers.min
            let max = Constants.ValidNumberOfPlayers.max
            guard ((min ... max).contains(numberOfPlayers)) else {
                return false
            }
            return true
        }
    }

    public static func hasReachedGoal(_ cash: Int) -> Bool {
        return (cash >= Constants.endGameCashTrigger)
    }

    static let totalDecks: Int = 14 // total number of families/groups/decks in the game
    static let totalCards: Int = 43 // total number of cards in the game
    static let sumOfCapacity: Int = 46 // when you add up all the orderCapacity from every card in teh game
    static let sumOfCosts: Int = 420 // when you total up all the deck costs together
    static let sumOfGenerations: Int = 34 // when you total up all the generation values in the decks together
    static let sumOfColors: Int = 30 // when you total up all the color values in the decks together
}
