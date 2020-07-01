//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

enum PlayerState: Int, CaseIterable {
    case waiting
    case onturn
    case thinking
}

protocol PlayerDelegate : AnyObject {
    var playerId: Int { get }
    var name: String { get }
    var cash: Int { get }
    var avatar: String { get }
}

class Player : NSObject, GKGameModelPlayer, Identifiable, WalletHolderDelegate, PlayerDelegate {
    var playerId: Int
    let name: String
    var cash: Int
    let avatar: String
    var cards: [Card]

    private(set) var state: PlayerState

    init(playerId: Int = 0, name: String, cash: Int, avatar: String) {
        self.playerId = playerId
        self.name = name
        self.cash = cash
        self.avatar = avatar
        self.state = .waiting
        self.cards = [Card]()
    }
}

extension Player {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return (lhs.playerId == rhs.playerId)
    }
}
