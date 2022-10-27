//
//  GameSetupManager.swift
//  EngineYard
//
//  Created by Amarjit on 27/10/2022.
//

import Foundation

class GameSetupManager {
    private var game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    func setup(for players: [Player]) throws -> Game? {
        guard Constants.NumberOfPlayers.isValid(players.count) else {
            return nil
        }
        
        let board = Board()
        board.prepare()
        
        switch (players.count) {
        case 3, 4:
            // In a 3-4 player game, give each player 12 coins
            // Give each player 1x First Gen Green card, and add 1 production unit to each one
            // Add 3 orders to the first train, Add 1 order to the second train
            let seedCash = Constants.NumberOfPlayers.seedCashThreeOrFourPlayer
            
            guard let firstTrain = board.decks.first else {
                throw GameErrorDelegate.noTrainFound
            }
            
            guard (firstTrain.cards.count == players.count) else {
                throw GameErrorDelegate.notEnoughCardsInDeck
            }
            
            // set cash for 3-4 player game
            let _ = players.map {
                $0.setCash(balance: seedCash)
            }
            
            for _ in 1...players.count {
                firstTrain.loco.addOrder(order: Die.roll)
            }
            
            for item in firstTrain.cards {
                item.setProduction(Production(units: 1))
                
                for p in players {
                    let result = p.handleCardAction(card: item, action: .push(card: item))
                    switch result {
                    case .success:
                        // Add to game log
                        break
                    case .failure(let portErr):
                        throw portErr as Error
                    }
                }
            }
            break
            
        case 5:
            // In a 5 player game, give each player 14 coins
            // No-one has any cards
            // Add 1 order to the first train
            let seedCash = Constants.NumberOfPlayers.seedCashFivePlayer
            
            guard let firstTrain = board.decks.first else {
                throw GameErrorDelegate.noTrainFound
            }
            
            firstTrain.loco.addOrder(order: Die.roll)
            
            // set cash for 3-4 player game
            let _ = players.map {
                $0.setCash(balance: seedCash)
            }            
            break
            
        default:
            throw GameErrorDelegate.noGameObject
        }
        
        self.game.setGamePhase(.setup)
        self.game.setBoard(board)
        self.game.setPlayers(players)
        
        return self.game
    }
}
