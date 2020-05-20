//
//  Player+Helpers.swift
//  EngineYard
//
//  Created by Amarjit on 16/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

extension Player {
    public static func generatePlayers(howMany: Int) -> [Player]? {
        guard Constants.ValidNumberOfPlayers.isValid(howMany) else {
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