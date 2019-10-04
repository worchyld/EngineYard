//
//  SetupManager.swift
//  EngineYard
//
//  Created by Amarjit on 04/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

class SetupManager {
    static var instance = SetupManager()

    func setup(players: [Player]) throws -> GameModel? {

        do {
            if try Constants.NumberOfPlayers.valid(players.count)
            {
                let gameObj = GameModel()

                gameObj.board = Board()

                // Setup players
                switch players.count {
                case 3...4:
                    threePlayerSetup(game: gameObj)
                    break
                case 5:
                    fivePlayerSetup(game: gameObj)
                    break

                default:
                    assertionFailure("Error -- Invalid number of players")
                    break
                }

                return gameObj
            }
            else {
                return nil
            }

        } catch let error {
            print (error.localizedDescription)
            return nil
        }

    }
}

// # Setup for 3-4 players:
// Give each player 12 coins and
// one unowned First Generation Green locomotive card.
// Each player places one Production Unit counter
// on the locomotive card, with side “1” face up.
//
extension SetupManager {
    private func threePlayerSetup(game: GameModel) {

    }
}

//    # Setup for 5 players:
//    + Give each player 14 coins.
//    + No one starts with a locomotive card in play.
//    + Roll only 1 die and place it in the Initial Orders
//    area of the First Generation of the green Passenger locomotive.\
//
extension SetupManager {
    private func fivePlayerSetup(game: GameModel) {

    }
}






