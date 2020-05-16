//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

class Player : NSObject, GKGameModelPlayer {
    enum State: Int {
        case none
        case waiting
        case active
        case thinking
        case completed
    }

    private (set) var playerId: Int = 0
    private (set) var state: Player.State = .none
}

extension Player {
    public static func ==(lhs: Player, rhs: Player) -> Bool {
        return (lhs.playerId == rhs.playerId)
    }
}

extension Player  {
    override var description: String {
        return ("\(self.playerId)")
    }
}

extension Player  {
    func setPlayerId(playerId: Int = 0) {
        self.playerId = playerId
    }
}
