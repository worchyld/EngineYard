//
//  Game.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

/* This `GKGameModel` is very basic, I really don't know how to code a proper one */

class Game : NSObject, GKGameModel {
    var board: Board!

    var players: [GKGameModelPlayer]?
    var activePlayer: GKGameModelPlayer?

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
            self.players = inputModel.players
            self.activePlayer = inputModel.activePlayer
        }
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Game()
        copy.setGameModel(self)
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
        return Rules.isGameEndConditionMet(plyObj.cash)
    }
}

