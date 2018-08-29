//
//  GameSetupManager.swift
//  EngineYard
//
//  Created by Amarjit on 29/08/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class GameSetupManager {
    static let instance = GameSetupManager()

    private var game: Game?

    deinit {
        self.game = nil
    }

    func setup(with players: [Player]) -> Game? {
        do {
            if try (Rules.NumberOfPlayers.isValid(count: players.count)) {

                self.game = Game()
                self.game?.board = Board()

                // Setup players
                switch players.count {
                case 3...4:
                    setupThreePlayer(players)
                    break
                case 5:
                    setupFivePlayer(players)
                    break

                default:
                    assertionFailure("Error -- Invalid number of players")
                    return nil
                }

                game?.players = players

                return self.game
            }
        } catch let error {
            assertionFailure(error.localizedDescription)
            return nil
        }
        return nil
    }

}

// MARK: Three player setup

extension GameSetupManager {
    // # Setup for 3-4 players:
    // Give each player 12 coins and
    // one unowned First Generation Green locomotive card.
    // Each player places one Production Unit counter
    // on the locomotive card, with side “1” face up.

    fileprivate func setupThreePlayer(_ players: [Player]) {
        guard let gameObj = self.game else {
            assertionFailure("Temp Game object could not be initialised")
            return
        }
        guard let board = gameObj.board else {
            assertionFailure("Temp GameBoard object could not be initialised")
            return
        }
        guard (board.decks.count == Rules.Board.decks) else {
            assertionFailure("Temp GameBoard object has incorrect decks initialised")
            return
        }

        // Get first 2 decks
        let decks = board.decks[0...1]

        guard let firstDeck = decks.first else {
            return
        }
        guard let lastDeck = decks.last else {
            return
        }

        for _ in 1...3 {
            firstDeck.orderBook.add(.existingOrder)
        }
        lastDeck.orderBook.add(.existingOrder)


        // Give each player 12 coins
        self.applySeedCash(for: players)

        // Add first deck cards to players
        Deck.giveCardsFrom(deck: firstDeck, to: players)
    }
}

// MARK: Five player setup

extension GameSetupManager {
    //  # Setup for 5 players:
    //  + Give each player 14 coins.
    //  + No one starts with a locomotive card in play.
    //  + Roll only 1 die and place it in the Initial Orders
    //  area of the First Generation of the green Passenger locomotive.
    //
    fileprivate func setupFivePlayer(_ players: [Player]) {

        /*
        self.applySeedCash(to: players)

        guard let firstDeck = self.board.decks.first else {
            return
        }

        firstDeck.orderBook.add(.customerBase)
         */
    }
}

extension GameSetupManager {

    fileprivate func applySeedCash(for players:[Player]) {
        let amount = Rules.NumberOfPlayers.getSeedCash(forNumberOfPlayers: players.count)
        _ = players.map({
            do {
                try $0.wallet.credit(amount: amount)
            } catch let error {
                assertionFailure(error.localizedDescription)
            }
        })

    }

}
