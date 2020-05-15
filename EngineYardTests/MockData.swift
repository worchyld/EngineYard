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
