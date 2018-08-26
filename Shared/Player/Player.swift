//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

final class Player : NSObject {
    private let playerId: String = UUID().uuidString
    var name : String!
    var cash : Int {
        return self.wallet.balance
    }
    var wallet : Wallet = Wallet()
    lazy var hand : Hand = Hand(owner: self) // Hand of cards / Tableau

    init(name: String) {
        super.init()
        self.name = name
    }
}

extension Player {
    public static func ==(lhs: Player, rhs: Player) -> Bool {
        return (lhs.playerId == rhs.playerId)
    }
}
