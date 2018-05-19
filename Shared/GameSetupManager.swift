//
//  GameSetupManager.swift
//  EngineYard
//
//  Created by Amarjit on 13/05/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

final class GameSetupManager {
    static var instance = GameSetupManager()

    func setup(players: [Player]) -> Game? {
        do {
            if try (Rules.NumberOfPlayers.isValid(count: players.count)) {

                let game: Game = Game(players: players)

                // setup players
                switch game.players.count {
                case 3...4:
                    setupThreePlayer(game: game)
                    break
                case 5:
                    setupFivePlayer(game: game)
                    break

                default:
                    assertionFailure("Error -- Invalid number of players")
                    break
                }

                return game
            }
        } catch let error {
            print (error.localizedDescription)
            return nil
        }

        return nil
    }
}

extension GameSetupManager {
    //  # Setup for 3-4 players:
    //  Give each player 12 coins and
    //  one unowned First Generation Green locomotive card.
    //  Each player places one Production Unit counter
    //  on the locomotive card, with side “1” face up.
    //
    private func setupThreePlayer(game: Game) {
        let amount = Rules.SeedCash.threePlayer

        self.setSeedCash(amount: amount, game: game)

        // Get first 2 decks
        let decks = game.board.decks[0...1]

        guard let firstDeck = decks.first else {
            return
        }
        guard let lastDeck = decks.last else {
            return
        }

        for _ in 1...3 {
            firstDeck.orderBook.add(.customerBase)
        }
        lastDeck.orderBook.add(.customerBase)


    }

    //  # Setup for 5 players:
    //  + Give each player 14 coins.
    //  + No one starts with a locomotive card in play.
    //  + Roll only 1 die and place it in the Initial Orders
    //  area of the First Generation of the green Passenger locomotive.
    //
    private func setupFivePlayer(game: Game) {
        let amount = Rules.SeedCash.fivePlayer
        self.setSeedCash(amount: amount, game: game)

        guard let firstDeck = game.board.decks.first else {
            return
        }

        firstDeck.orderBook.add(.customerBase)
    }
}


extension GameSetupManager {
    private func setSeedCash(amount: Int, game: Game) {
        _ = game.players.map({
            do {
                try $0.wallet.credit(amount: amount)
            } catch let error {
                assertionFailure(error.localizedDescription)
            }
        })
    }
}
