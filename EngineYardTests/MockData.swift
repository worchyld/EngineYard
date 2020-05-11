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

/*
struct ExpectedData {
    static let totalDecks: Int = 14 // total number of decks
    static let totalCards: Int = 43 // total number of cards

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
    static func numberOfGenerations(with color: Deck.Color) -> Int {
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
*/
