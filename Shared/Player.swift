//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import GameKit

class Player : NSObject, GKGameModelPlayer, Identifiable {
    var playerId: Int
    var name: String
    var cash: Int
    var avatar: String

    enum State: Int, CaseIterable {
        case waiting
        case onturn
        case thinking
    }

    var state: Player.State = .waiting
    var hand: [Card] = [Card]()

    init(playerId: Int = 0, name: String, cash: Int, avatar: String) {
        self.playerId = playerId
        self.name = name
        self.cash = cash
        self.avatar = avatar
    }
}

extension Player {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return (lhs.playerId == rhs.playerId)
    }

}
