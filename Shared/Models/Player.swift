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
    public private (set) var cash : Int
    public private (set) var icon : String?
    public private (set) var turnOrder: Int
    public private (set) var hand: [Card]
    
    init(cash: Int = 0, icon: String? = nil) {
        self.playerId = 0
        self.cash = cash
        self.icon = icon
        self.turnOrder = 0
        self.hand = [Card]()
    }
}

extension Player {
    func setCash(amount: Int) {
        self.cash = amount
    }
}
