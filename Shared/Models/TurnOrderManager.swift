//
//  TurnOrderManager.swift
//  EngineYard
//
//  Created by Amarjit on 17/04/2023.
//

import Foundation

class TurnOrderManager {
    private let players: [Player]
    
    init(players: [Player]) {
        self.players = players
    }
    
    func sort() -> [Player] {
        return self.players.sorted { p1, p2 in
            return p1.cash < p2.cash
        }
    }
}
