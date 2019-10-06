//
//  GameModel.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

enum GamePhase: Int {
    case PurchaseLocomotivePhase = 0
    case PurchaseProductionPhase
    case SellingPhase
    case PayTaxesPhase
    case MarketDemandsPhase
    case CheckEndGameTriggerPhase
    case DeclareWinnerPhase
}

final class GameModel: NSObject, GKGameModel {
    var phase: GamePhase?
    var players: [GKGameModelPlayer]?
    var activePlayer: GKGameModelPlayer?
    var board: Board?
}

// Required by protocol
extension GameModel {
    func setGameModel(_ gameModel: GKGameModel) {
        if let sourceModel = gameModel as? GameModel {
            self.phase = sourceModel.phase
            guard let activePlayer = sourceModel.activePlayer else {
                return
            }
            self.activePlayer = activePlayer
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

