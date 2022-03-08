//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 08/03/2022.
//

import Foundation
import GameplayKit

public enum PlayerState {
    case waiting, thinking, done
}

// TBD
class Player: NSObject, GKGameModelPlayer {
    var playerId: Int = 0
    
    var name : String = ""
    var avatar : String = ""
    var cash : Int = 0
    var state : PlayerState = .waiting
    var onTurn : Bool = false 
    
    //var hand: [Cards]
}
