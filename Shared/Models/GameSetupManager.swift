//
//  GameSetupManager.swift
//  EngineYard
//
//  Created by Amarjit on 29/05/2023.
//

import Foundation

class GameSetupManager {
    internal var game: Game
    
    init(game: Game) {
        self.game = game
    }
        
    func setup(for players: [Player]) throws -> Game? {
        guard Constants.NumberOfPlayers.isValid(players.count) else {
            throw GameErrorDelegate.invalidPlayerCount
        }
        
        let board = prepareBoard()
        
        switch players.count {
        case 3,4:
            // setup 3-4 player game
            do {
                try self.setupThreeOrFourPlayerGame(board: board, players: players)
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
            throw GameErrorDelegate.invalidPlayerCount
        }
        
        let game = Game(board: board, players: players)
        return game
    }
 
    internal func prepareBoard() -> Board {
        let presetLocos = Locomotive.allLocos()
        
        var locomotives: [Locomotive] = [Locomotive]()
            
        for loco in presetLocos {
            loco.cards = [Card]()
            
            for _ in 1...loco.trainPool {
                let card = Card(locomotive: loco, productionUnits: 0)
                loco.cards?.append(card)
            }
            
            locomotives.append(loco)
        }
        
        let board = Board(spaces: locomotives)
        return board
    }
    
    // In a 3-4 player game, give each player 12 coins
    // Give each player 1x First Gen Green card, and add 1 production unit to each one
    // Add 3 orders to the first train, Add 1 order to the second train
    private func setupThreeOrFourPlayerGame(board: Board, players: [Player]) throws {
        guard let firstTrain = board.spaces.first else {
           throw GameErrorDelegate.invalidBoardData
        }
        guard var cards = firstTrain.cards else {
            throw GameErrorDelegate.invalidBoardData
        }

        
        // Set seedCash of $12
        let cash = Constants.NumberOfPlayers.seedCash(players: 3)
        
        let _ = players.map {
            $0.setCash(amount: cash)
        }
        
        // In a 3-player game, remove the last card of the first deck; its not used.
        if (players.count == 3) {
            let _ = cards.popLast()
        }
        
        for _ in 1...players.count {
            do {
                let om = OrderManager(loco: firstTrain)
                try om.addInitialOrder()
            } catch let err {
                throw err            }
        }
        
        for item in cards {
            let pm = ProductionManager(card: item)
            do {
                try pm.add(units: 1)
            } catch let err {
                throw err
            }
            
//            for _ in players {
//                print ("Trying to add card to players hand: \(item.debugDescription)")
//                
//                /*
//                let result = p.handleCardAction(card: item, action: .push(card: item))
//                switch result {
//                case .success:
//                    // Add to game log
//                    break
//                case .failure(let portErr):
//                    throw portErr as Error
//                }*/
//            }
            
        }
        
    }
    
    // In a 5 player game, give each player 14 coins
    // No-one has any cards
    // Add 1 order to the first train
    private func setupFivePlayerGame(board: Board, players: [Player]) throws {
        guard let _ = board.spaces.first else {
           throw GameErrorDelegate.noBoardDefined
        }
        
        // Set seedCash of $14
        let cash = Constants.NumberOfPlayers.seedCash(players: 5)
        
        let _ = players.map {
            $0.setCash(amount: cash)
        }
                
        guard let firstTrain = board.spaces.first else {
            throw GameErrorDelegate.noGameObject
        }
        
        let om = OrderManager(loco: firstTrain)
        do {
            try om.addInitialOrder()
        } catch let err {
            throw err
        }
    }
}
