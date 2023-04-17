//
//  GameModel.swift
//  EngineYard
//
//  Created by Amarjit on 17/04/2023.
//

import Foundation
import GameplayKit

final class GameModel: NSObject, GKGameModel {
    var players: [GKGameModelPlayer]?
    
    var activePlayer: GKGameModelPlayer?
    
    func setGameModel(_ gameModel: GKGameModel) {
        //let sourceModel = gameModel as! GameModel
    }
    
    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        return nil
    }
    
    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = GameModel()
        copy.setGameModel(self)
        return copy
    }
    
    
}
