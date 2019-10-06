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
        game.board = Board()
        game.players = (players as [GKGameModelPlayer])

        switch players.count {
        case 3, 4:
            threePlayerSetup(game: game)
            break
        case 5:
            fivePlayerSetup(game: game)
            break
        default:
            assertionFailure("Invalid player count")
            break
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
    private func threePlayerSetup(game: GameModel) {
        guard let board = game.board else {
            return
        }
        // Get first 2 decks
        let firstTwoDecks = board.decks[0...1]

        guard let firstDeck = firstTwoDecks.first else {
            assertionFailure("No first deck")
            return
        }
        guard let secondDeck = firstTwoDecks.last else {
            assertionFailure("No second deck")
            return
        }
        for _ in 0...3 {
            firstDeck.orderBook.add()
        }
        secondDeck.orderBook.add()

        guard let players = game.players else {
            return
        }
        let _ = players.map({
            let p = ($0 as! Player)
            do {
                let result = try p.wallet.credit(amount: Constants.threePlayerSeedCash)
                print ("result: \(result ?? 0)")
            } catch let error {
                print (error)
                return
            }
        })

        // Give each player: 1x first green card with 1 unit production
        /*
        guard let card = (firstDeck.cards.filter({
            return $0.owner == nil
        }).first) else {
            assertionFailure("All cards have an owner")
        }
        */
    }
}

//    # Setup for 5 players:
//    + Give each player 14 coins.
//    + No one starts with a locomotive card in play.
//    + First deck gets 1 order
extension SetupManager {
    private func fivePlayerSetup(game: GameModel) {
        guard let board = game.board else {
            return
        }
        guard let firstDeck = board.decks.first else {
            assertionFailure("No first deck")
            return
        }
        firstDeck.orderBook.add()

        // Player setup
        guard let players = game.players else {
            return
        }
        let _ = players.map({
            let p = ($0 as! Player)
            do {
                let _ = try p.wallet.credit(amount: Constants.fivePlayerSeedCash)
            } catch let error {
                print (error)
                return
            }
        })
    }
}
