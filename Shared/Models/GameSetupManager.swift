//
//  GameSetupManager.swift
//  EngineYard
//
//  Created by Amarjit on 29/05/2023.
//

import Foundation

class GameSetupManager {
    private var game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    func setup(for players: [Player]) throws -> Game {
        guard Constants.NumberOfPlayers.isValid(players.count) else {
            throw GameErrorDelegate.notAValidPlayerCount
        }
        
        let board = self.prepareBoard()
        
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

        self.game.setBoard(to: board)
        self.game.setGamePhase(to: .mainMenu)

        return self.game
    }
    
    private func prepareBoard() -> Board {
        let allLocos = Locomotive.allLocos()
        var spaces: [Space] = [Space]()
        for loco in allLocos {
            let space = Space.init(loco: loco)
            spaces.append(space)
        }
        let board = Board.init(spaces: spaces)
        
        return board
    }
    
    // In a 3-4 player game, give each player 12 coins
    // Give each player 1x First Gen Green card, and add 1 production unit to each one
    // Add 3 orders to the first train, Add 1 order to the second train
    private func setupThreePlayerGame(board: Board, players: [Player]) throws {
        guard let firstSpace = board.spaces.first else {
           throw GameErrorDelegate.noBoardDefined
        }
        let firstLoco = firstSpace.loco
        
        // Set seedCash of $12
        let cash = Constants.NumberOfPlayers.seedCash(players: 3)
        
        let _ = players.map {
            $0.setCash(amount: cash)            
        }
        
        if (players.count == 3) {
        }
        for _ in 1...players.count {
            let om = OrderManager.init(loco: firstLoco)
            do {
                try om.addInitialOrder()
            }
            catch let err {
                throw err
            }
        }
        
        
    }
    
    // In a 5 player game, give each player 14 coins
    // No-one has any cards
    // Add 1 order to the first train
    private func setupFivePlayerGame(board: Board, players: [Player]) throws {
        
    }
    

    
}