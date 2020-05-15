//
//  MockData.swift
//  EngineYardTests
//
//  Created by Amarjit on 11/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

@testable import EngineYard

public struct MockData {
    public static func players(howMany: Int) -> [Player]? {
        guard Constants.Players.valid(howMany) else {
            return nil
        }

        var players: [Player] = [Player]()

        for index in stride(from:0, to: howMany, by: 1) {
            let player = Player.init()
            player.playerId = index
            players.append(player)
        }

        return players
    }
}


extension Board {
    // Used for testing
    struct ExpectedData {
        static let totalDecks: Int = 14 // total number of decks
        static let totalCards: Int = 43 // total number of cards
        static let sumOfCapacity: Int = 46 // total amount of capacity allowed
        static let sumOfCosts: Int = 420 // when you total up all the deck costs together
        static let sumOfGenerations: Int = 34 // when you total up all the generation values in the decks together
        static let sumOfColors: Int = 30 // when you total up all the color values in the decks together

        // There are 43 cards (see: totalCards) the game:
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
    }
}
