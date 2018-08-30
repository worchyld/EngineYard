//
//  TurnOrderManager.swift
//  EngineYard
//
//  Created by Amarjit on 29/08/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// Handles Turn management
class TurnOrderManager : NSObject {
    static var instance =  TurnOrderManager()

    public private(set) var turnOrderIndex: Int = 0
    var turnOrder: [Player] = [Player]()
    var currentPlayer: Player {
        return self.turnOrder[self.turnOrderIndex]
    }

    public func next() {
        if (turnOrderIndex < (self.turnOrderIndex.count - 1)) {
            turnOrderIndex += 1
        }
        else {
            turnOrderIndex = 0
        }
    }

}
