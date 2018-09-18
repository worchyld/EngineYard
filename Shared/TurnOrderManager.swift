//
//  TurnOrderManager.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

protocol TurnDelegate {
    func turnDidEnd()
    func allTurnsDidComplete()
}

protocol TurnOrderManagerDelegate {
    func turnOrderWasSet()
}


class TurnOrderManager : TurnOrderManagerDelegate {
    static var instance = TurnOrderManager()

    public private(set) var turnOrderIndex: Int = 0

    func turnOrderWasSet() {
//        for (index, p) in self.turnOrder.enumerated() {
//            p.setTurnOrderIndex(number: index)
//        }
    }

    public func shuffleTurnOrder() {
        //self.turnOrder.shuffle()
    }

    public func next() {
        /*
        if (turnOrderIndex < (self.turnOrder.count - 1)) {
            turnOrderIndex += 1
        }
        else {
            turnOrderIndex = 0
        }*/
    }
}
