//
//  SetupManager.swift
//  EngineYard
//
//  Created by Amarjit on 04/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

class SetupManager {
    static var instance = SetupManager()

    func setup(players: [Player]) -> GameModel? {
        guard Constants.Players.valid(players.count) else {
            return nil
        }
        let game: GameModel = GameModel()
        for p in players {
            game.players?.append(p as! GKGameModelPlayer)
        }
        return game
    }
}

extension SetupManager {
    public static func createPlayers(howMany: Int) -> [Player]? {
        guard Constants.Players.valid(howMany) else {
            assertionFailure("Invalid player count")
            return nil
        }

        var players: [Player] = [Player]()
        
        for index in 1...howMany {
            let name = "Player #\(index)"
            var isAI: Bool = true
            if (index == 1) {
                isAI = false
            }

            let playerObj = Player.init(name: name, isAI: isAI)
            players.append(playerObj)
        }
        return players
    }
}

// # Setup for 3-4 players:
// Give each player 12 coins and
// one unowned First Generation Green card.
// Each player places one Production Unit counter
extension SetupManager {
    private func threePlayerSetup() {

    }
}

//    # Setup for 5 players:
//    + Give each player 14 coins.
//    + No one starts with a locomotive card in play.
//    + Roll only 1 die and place it in the Initial Orders
//    area of the First Generation of the green Passenger locomotive.\
extension SetupManager {
    private func fivePlayerSetup() {

    }
}
