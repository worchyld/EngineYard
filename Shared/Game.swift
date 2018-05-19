//
//  Game.swift
//  EngineYard
//
//  Created by Amarjit on 20/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// Game
final class Game : NSObject {
    var board: Board!
    var players: [Player] = [Player]()
    var dateCreated: Date?

    init(players: [Player]) {
        super.init()
        self.board = Board()
        self.players = players

        self.setup(players: self.players)
    }
}

extension Game {

    func setup(players: [Player]) {
        do {
            if try (Rules.NumberOfPlayers.isValid(count: players.count)) {

                let game: Game = Game(players: players)

                // setup players
                switch game.players.count {
                case 3...4:
                    setupThreePlayer()
                    break
                case 5:
                    setupFivePlayer()
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

}


// MARK: - (Private) functions

extension Game {
    //  # Setup for 3-4 players:
    //  Give each player 12 coins and
    //  one unowned First Generation Green locomotive card.
    //  Each player places one Production Unit counter
    //  on the locomotive card, with side “1” face up.
    //
    private func setupThreePlayer() {
        self.applySeedCash(to: players)

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
    }



    //  # Setup for 5 players:
    //  + Give each player 14 coins.
    //  + No one starts with a locomotive card in play.
    //  + Roll only 1 die and place it in the Initial Orders
    //  area of the First Generation of the green Passenger locomotive.
    //
    private func setupFivePlayer() {
        self.applySeedCash(to: players)

        guard let firstDeck = self.board.decks.first else {
            return
        }

        firstDeck.orderBook.add(.customerBase)
    }

    private func applySeedCash(to players:[Player]) {
        let amount = Rules.NumberOfPlayers.getSeedCash(players: players.count)

        _ = players.map({
            do {
                try $0.wallet.credit(amount: amount)
            } catch let error {
                assertionFailure(error.localizedDescription)
            }
        })
    }
}
