//
//  GameSetupManager.swift
//  EngineYard
//
//  Created by Amarjit on 29/05/2023.
//

import Foundation

class GameSetupManager {
        
    func setup(for players: [Player]) throws -> Game {
        guard Constants.NumberOfPlayers.isValid(players.count) else {
            throw GameErrorDelegate.notAValidPlayerCount
        }
        
        let board = prepareBoard()
        
        switch players.count {
        case 3,4:
            // setup 3-4 player game
            do {
                try self.setupThreePlayerGame(board: board, players: players)
            } catch let err {
                throw err
            }
        case 5:
            // setup 5 player game
            do {
                try self.setupFivePlayerGame(board: board, players: players)
            } catch let err {
                throw err
            }
        default:
            throw GameErrorDelegate.notAValidPlayerCount
        }
        
        let game = Game.init(board: board, gamePhase: .setup)
        return game
    }
    
    internal func prepareBoard() -> Board {
        let allLocos = Locomotive.allLocos()
        
        var decks: Deck<Locomotive>
            
        for loco in allLocos {
            let deck: Deck<Locomotive> = Deck()

            for _ in 0...loco.trainPool {
                let card = Card(locomotive: loco, productionUnits: 0)
                deck.push(card)
            }
            
            decks.push(deck)
        }
        
        for loco in decks {
            print (loco.debugDescription)
        }
        
        let board = Board.init(decks: decks)        
        return board
    }
    
    // In a 3-4 player game, give each player 12 coins
    // Give each player 1x First Gen Green card, and add 1 production unit to each one
    // Add 3 orders to the first train, Add 1 order to the second train
    private func setupThreePlayerGame(board: Board, players: [Player]) throws {
//        guard let firstSpace = board.spaces.first else {
//           throw GameErrorDelegate.noBoardDefined
//        }
//        let firstLoco = firstSpace.loco
//        
//        // Set seedCash of $12
//        let cash = Constants.NumberOfPlayers.seedCash(players: 3)
//        
//        let _ = players.map {
//            $0.setCash(amount: cash)            
//        }
//        
//        if (players.count == 3) {
//        }
//        for _ in 1...players.count {
//            let om = OrderManager.init(loco: firstLoco)
//            do {
//                try om.addInitialOrder()
//            }
//            catch let err {
//                throw err
//            }
//        }
        
        
    }
    
    // In a 5 player game, give each player 14 coins
    // No-one has any cards
    // Add 1 order to the first train
    private func setupFivePlayerGame(board: Board, players: [Player]) throws {
        
    }
    

    
}
