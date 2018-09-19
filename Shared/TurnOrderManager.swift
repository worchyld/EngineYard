//
//  TurnOrderManager.swift
//  EngineYardTests
//
//  Created by Amarjit on 19/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class TurnOrderManager {
    static var instance = TurnOrderManager()

    var turnOrderIndex : Int {
        return self.turnOrderIndex
    }

    private var _turnOrderIndex: Int = 0

    func shuffleTurnOrder() {
        guard let hasPlayers = self.players else {
            return
        }
        self.players = hasPlayers.shuffled()
    }

    func nextOnTurn() {
        guard let hasPlayers = self.players else {
            return
        }
        if (turnOrderIndex < (hasPlayers.count - 1)) {
            turnOrderIndex += 1
        }
        else {
            turnOrderIndex = 0
        }
        self.activePlayer = hasPlayers[turnOrderIndex]
    }
}
