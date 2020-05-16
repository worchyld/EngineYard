//
//  GameModel.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

final class GameModel: NSObject, GKGameModel {
    var players: [GKGameModelPlayer]?
    var activePlayer: GKGameModelPlayer?
}

// Required by protocol
extension GameModel {
    func setGameModel(_ gameModel: GKGameModel) {
        if let model = gameModel as? GameModel {
            self.activePlayer = model.activePlayer
        }
    }

    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        return nil
    }

    func unapplyGameModelUpdate(_ gameModelUpdate: GKGameModelUpdate) {
    }

    func apply(_ gameModelUpdate: GKGameModelUpdate) {
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = GameModel()
        copy.setGameModel(self)
        return copy
    }
}
