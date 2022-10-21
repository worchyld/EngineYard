//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 08/03/2022.
//

import Foundation
import GameplayKit

public enum PlayerState: Int {
    case waiting = 0, thinking, done
}

// TBD
class Player: NSObject, GKGameModelPlayer {
    var playerId: Int = 0
    
    var name : String = ""
    var avatar : String = ""
    private var cash : Int = 0
    public var balance: Int {
        return self.cash
    }
    var state : PlayerState = .waiting
    var onTurn : Bool = false 
    
    var hand: [Card] = [Card]()
}

extension Player {
    public func setCash(balance: Int = 0) {
        guard (balance >= 0) else { return }
        self.cash = balance
    }
}
