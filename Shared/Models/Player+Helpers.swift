//
//  Player+Helpers.swift
//  EngineYard
//
//  Created by Amarjit on 16/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

extension Player {

    public static func isValidNumberOfPlayers(_ numberOfPlayers: Int) -> Bool {
        /*guard ((Constants.Players.min ... Constants.Players.max).contains(numberOfPlayers)) else {
            throw ErrorCode.invalidNumberOfPlayers
        }*/
        guard ((Constants.Players.min ... Constants.Players.max).contains(numberOfPlayers)) else {
            return false
        }
        return true
    }

    public static func getSeedCash(for numberOfPlayers: Int) -> Int? {
        switch numberOfPlayers {
        case 3:
            return Constants.SeedCash.threePlayer
        case 4, 5:
            return Constants.SeedCash.fivePlayer
        default:
            return nil
        }
    }

    public static func generatePlayers(howMany: Int) -> [Player]? {
        guard Player.isValidNumberOfPlayers(howMany) else {
            return nil
        }

        var players: [Player] = [Player]()

        for index in stride(from:0, to: howMany, by: 1) {
            let player = Player.init()
            player.setPlayerId(playerId: index)
            players.append(player)
        }

        return players
    }
}
