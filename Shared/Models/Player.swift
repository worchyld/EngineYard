//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

protocol PlayerProtocol {
    var playerId: Int { get set }
    var state: Player.State { get set }
    var hand: Hand { get }
}

class Player : NSObject, GKGameModelPlayer, PlayerProtocol {
    enum State: Int {
        case none
        case waiting
        case active
        case thinking
        case completed
    }

    var playerId: Int = 0
    var state: Player.State = .none
    let hand: Hand = Hand() // A player has a hand of cards
}

extension Player {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return (lhs.isEqual(rhs))
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
