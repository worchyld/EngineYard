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
    
    private func prepareBoard() -> Board {
        var decks: [Deck] = [Deck]()
        
        // Prepare the board, decks, cards
        let locos = Locomotive.allLocos()
        
        for loco in locos {
            let deck: Deck = Deck(loco: loco)
            
            for _ in 1...loco.qty {
                let card = Card(id: UUID(), locomotive: loco)
                deck.push(card)
            }
            
            decks.append(deck)
        }
        
        let board = Board.init(with: decks)
        return board
    }
    
    func setup(for players: [Player]) throws -> Game {
        guard Constants.NumberOfPlayers.isValid(players.count) else {
            throw GameErrorDelegate.noPlayerFound
        }
        
        let board = self.prepareBoard()
        
        
        switch (players.count) {
        case 3,4:
            // In a 3-4 player game, give each player 12 coins
            // Give each player 1x First Gen Green card, and add 1 production unit to each one
            // Add 3 orders to the first train, Add 1 order to the second train
            
            guard let firstTrain = board.decks.first else {
                throw GameErrorDelegate.noTrainFound
            }
            
            // Set seedCash = $12
            let seedCash = Constants.NumberOfPlayers.seedCashThreeOrFourPlayer
            let _ = players.map {
                $0.setCash(balance: seedCash)
            }
                        
            if (players.count == 3) {
                let _ = firstTrain.cards.popLast()
                let _ = firstTrain.loco.reduceQtyBy1()
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
            guard let firstTrain = board.decks.first else {
                throw GameErrorDelegate.noTrainFound
            }
            firstTrain.loco.addOrder(order: Die.roll)
            
            // Set seed cash: $14
            let _ = players.map {
                let seedCash = Constants.NumberOfPlayers.seedCashFivePlayer
                $0.setCash(balance: seedCash)
            }
            break
            
        default:
            throw GameErrorDelegate.playerCountIsInvalid
        }
        
        self.game.setGamePhase(.setup)
        self.game.setBoard(board)
        self.game.setPlayers(players)
        
        return self.game
    }
}
