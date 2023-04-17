//
//  Player.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation
import GameplayKit

class Player: NSObject, GKGameModelPlayer {
    
    var playerId: Int
    var cash : Int
    var icon : String?
    var onTurn: Bool = false
    var hand: [Card] = [Card]()
    
    init(cash: Int = 0, icon: String? = nil) {
        self.playerId = 0
        self.cash = cash
        self.icon = icon
    }
}
