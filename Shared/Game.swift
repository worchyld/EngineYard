//
//  Game.swift
//  EngineYard
//
//  Created by Amarjit on 20/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// Game

class Game : NSObject {
    static var instance = Game()
    var board: GameBoard!
    var players: [Player] = [Player]()
    var dateCreated: Date?

    override init() {
        super.init()
        self.board = GameBoard()
    }
}

extension Game {

    func setup(players: [Player]) {
        do {
            if try (Rules.NumberOfPlayers.isValid(count: players.count)) {
                self.players = players

                // setup players
                switch players.count {
                case 3...4:
                    setupThreePlayerGame()
                    break
                case 5:
                    setupFivePlayerGame()
                    break

                default:
                    assertionFailure("Error -- Invalid number of players")
                    break
                }
            }
        } catch let error {
            print (error.localizedDescription)
        }
    }

    // # Setup for 3-4 players:
    // Give each player 12 coins and
    // one unowned First Generation Green locomotive card.
    // Each player places one Production Unit counter
    // on the locomotive card, with side “1” face up.
    //
    private func setupThreePlayerGame() {
        let amount = Rules.SeedCash.threePlayer
        self.setSeedCash(amount: amount)

        // Get first 2 decks
        let decks = self.board.decks[0...1]

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

        // Give each player 1 card from the firstDeck
    }

    //    # Setup for 5 players:
    //    + Give each player 14 coins.
    //    + No one starts with a locomotive card in play.
    //    + Roll only 1 die and place it in the Initial Orders
    //    area of the First Generation of the green Passenger locomotive.
    //
    private func setupFivePlayerGame() {
        let amount = Rules.SeedCash.fivePlayer
        self.setSeedCash(amount: amount)
    }

    private func setSeedCash(amount: Int) {
        _ = players.map({
            do {
                try $0.wallet.credit(amount: amount)
            } catch let error {
                assertionFailure(error.localizedDescription)
            }
        })

        guard let firstDeck = self.board.decks.first else {
            return
        }

        firstDeck.orderBook.add(.customerBase)
    }

}
