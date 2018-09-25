//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

class Player : NSObject, NSCopying, GKGameModelPlayer {
    internal var playerId: Int = 0 {
        didSet {
            print ("Set playerId = \(self.playerId)")
        }
    }

    var name : String!
    var cash : Int {
        return self.wallet.balance
    }
    var wallet : Wallet = Wallet()
    lazy var hand : Hand = Hand(owner: self) // Hand of cards

    init(name: String) {
        self.name = name
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let player = Player.init(name: self.name)
        player.playerId = self.playerId
        player.wallet = self.wallet
        player.hand = self.hand
        return player
    }
}

extension Player {
    public static func ==(lhs: Player, rhs: Player) -> Bool {
        return (lhs.playerId == rhs.playerId)
    }

    override var description: String {
        return ("\(playerId) - \(self.name!), $\(self.cash), \(self.hand.description)\n")
    }

    func setPlayerId(_ playerId: Int) {
        self.playerId = playerId
    }
}

