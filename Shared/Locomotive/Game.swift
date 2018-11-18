//
//  Game.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

protocol TurnOrderUpdateDelegate {
    func updateTurnOrder()
}

/* This `GKGameModel` is very basic, I really don't know how to code a proper one */

class Game : NSObject, GKGameModel, TurnOrderUpdateDelegate {
    var board: Board!
    var turnOrderIndex = 0

    // -- GKGameModel code follows --
    var players: [GKGameModelPlayer]?
    var activePlayer: GKGameModelPlayer?
    lazy var delegate: TurnOrderUpdateDelegate = self

    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        return nil
    }

    func unapplyGameModelUpdate(_ gameModelUpdate: GKGameModelUpdate) {
    }


    func apply(_ gameModelUpdate: GKGameModelUpdate) {

    }

    func setGameModel(_ gameModel: GKGameModel) {
        if let inputModel = gameModel as? Game {
            self.board = inputModel.board
            self.activePlayer = inputModel.activePlayer
            self.turnOrderIndex = inputModel.turnOrderIndex
        }
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Game()
        copy.setGameModel(self)
        copy.board = self.board.copy(with: zone) as? Board

        let duplicate = self.players?.map({ (player: GKGameModelPlayer) -> GKGameModelPlayer in
            let person = player as! Player
            let copiedPlayer = person.copy(with: zone) as! Player
            return copiedPlayer
        })
        copy.players = duplicate

        return copy
    }

    func score(for player: GKGameModelPlayer) -> Int {
        return 0
    }
}

extension Game {
    override var description: String {
        return ("[Game]: \(board.description), \(String(describing: self.players)), active: \(String(describing: self.activePlayer))")
    }

    public static func setup(with players:[Player]) -> Game? {
        return (GameSetupManager().setup(with: players))
    }

    func isWin(for player: GKGameModelPlayer) -> Bool {
        let plyObj: Player = player as! Player
        return Rules.didMeetEndGameCondition(plyObj.cash)
    }
}

extension Game {
    func shuffleTurnOrder() {
        guard let hasPlayers = self.players else {
            return
        }
        self.players = hasPlayers.shuffled()
        delegate.updateTurnOrder()
    }
    
    func nextOnTurn() {
        guard let hasPlayers = self.players else {
            return
        }
        if (turnOrderIndex < (hasPlayers.count - 1)) {
            turnOrderIndex += 1
        }
        else {
            turnOrderIndex = 0
        }
        self.activePlayer = hasPlayers[turnOrderIndex]
    }

    // MARK: TurnOrderUpdateDelegate method
    func updateTurnOrder() {
        guard let players = self.players as? [Player] else {
            return
        }
        for (index, p) in players.enumerated() {
            p.setTurnOrderIndex(index)
            
        }
    }
}
