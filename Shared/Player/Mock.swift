//
//  Mock.swift
//  EngineYard
//
//  Created by Amarjit on 19/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

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
}
