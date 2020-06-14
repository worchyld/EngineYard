//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

class Player : NSObject, GKGameModelPlayer, Identifiable {
    var playerId: Int
    let name: String
    private(set) var cash: Int
    let avatar: String

    enum State: Int, CaseIterable {
        case waiting
        case onturn
        case thinking
    }

    private(set) var state: Player.State = .waiting
    private(set) var hand: [Card] = [Card]()

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

extension Player {
    func setHand(cards: [Card]) {
        self.hand = cards
    }
}

extension Player {
    func setCash(_ cash: Int) {
        self.cash = cash
    }
}

extension Player {
    func setState(_ state: Player.State) {
        self.state = state
    }
}
