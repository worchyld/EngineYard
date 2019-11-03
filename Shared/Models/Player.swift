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
    var playerId: Int
    
    let name: String
    let isAI: Bool
    var cash: Int {
        return (self.wallet.balance)
    }
    let wallet: Wallet = Wallet() // REFACTOR: Probably should remove this reference and make the wallet static
    lazy var hand: Hand = Hand(owner: self) // hand of cards
    let avatar: String
    public private (set) var turnOrder: Int

    init(id: Int = 0, name: String, isAI: Bool = true) {
        self.name = name
        self.isAI = isAI
        self.avatar = ""
        self.playerId = id
        self.turnOrder = 0
    }
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

extension Player {
    func setTurnOrderIndex(number: Int) {
        self.turnOrder = number
    }
}
