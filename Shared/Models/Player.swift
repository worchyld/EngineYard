//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

enum PlayerState: Int {
    case inactive
    case active
    case thinking
}

class Player : NSObject, GKGameModelPlayer {
    var playerId: Int = 0
    let name: String = ""
    var cash: Int = 0
}

extension Player {
    public static func ==(lhs: Player, rhs: Player) -> Bool {
        return (lhs.playerId == rhs.playerId)
    }
}

extension Player  {
    override var description: String {
        return ("\(self.name), cash: $\(self.cash)")
    }
}
