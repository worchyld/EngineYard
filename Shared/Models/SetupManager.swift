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
                    // # TODO
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
        guard let board = game.board else {
            assertionFailure("GameBoard is not defined")
            return
        }

        guard let seedCash = Constants.NumberOfPlayers.setSeedCash(for: 3) else {
            assertionFailure("Invalid number of players")
            return
        }

        for player in game.players as! [Player] {
            do {
                let _ = try player.wallet.credit(amount: seedCash)
            } catch {
                assertionFailure("`(error)")
                break
            }
        }

        // Get first 2 decks
        let decks = board.decks[0...1]

        guard let firstDeck = decks.first else {
            assertionFailure("No first deck found")
            return
        }

        guard let lastDeck = decks.last else {
            assertionFailure("No last deck found")
            return
        }

        assert(firstDeck.generation == .first && firstDeck.color == .green)
        assert(lastDeck.generation == .first && lastDeck.color == .red)

        // Give each player a card from first deck (if possible)
        for player in game.players as! [Player] {
            guard let card = Card.findFirstUnownedCard(in: firstDeck) else {
                assertionFailure("Cant find any unowned cards")
                return
            }
            let _ = player.hand.push(card: card)
        }

        //firstDeck.orders.add()
        //lastDeck.orders.add()
        
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






