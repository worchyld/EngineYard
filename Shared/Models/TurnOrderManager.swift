//
//  TurnOrderManager.swift
//  EngineYard
//
//  Created by Amarjit on 17/04/2023.
//

import Foundation

class TurnOrderManager {
    private let players: [Player]
    private var onTurnIndex: Int = 0
    
    init(players: [Player], onTurnIndex: Int = 0) {
        self.players = players
        self.onTurnIndex = onTurnIndex
    }
    
    func sort() -> [Player] {
        return self.players.sorted { p1, p2 in
            return p1.cash < p2.cash
        }
    }
    
    func nextOnTurn() -> Int {
        onTurnIndex += 1
        if (onTurnIndex >= self.players.count) {
            onTurnIndex = 0
        }
        return onTurnIndex
    }
}
