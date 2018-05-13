//
//  GameModel.swift
//  EngineYard
//
//  Created by Amarjit on 13/05/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

class GameModel : NSObject, GKGameModel {
    var players: [GKGameModelPlayer]?
    var activePlayer: GKGameModelPlayer?

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = GameModel()
        copy.setGameModel(self)
        return copy
    }

    func setGameModel(_ gameModel: GKGameModel) {

    }

    func unapplyGameModelUpdate(_ gameModelUpdate: GKGameModelUpdate) {

    }

    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        return []
    }

    func apply(_ gameModelUpdate: GKGameModelUpdate) {

    }

    func score(for player: GKGameModelPlayer) -> Int {
        return 0
    }

    func isWin(for player: GKGameModelPlayer) -> Bool {
        return false
    }

    func isLoss(for player: GKGameModelPlayer) -> Bool {
        return false
    }
}
