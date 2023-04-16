//
//  Player.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation

class Player {
    var cash : Int
    var icon : String?
    var onTurn: Bool = false
    var hand: [Card] = [Card]()
    
    init(cash: Int = 0, icon: String? = nil) {
        self.cash = cash
        self.icon = icon
    }
}
