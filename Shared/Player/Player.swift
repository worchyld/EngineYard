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
        }
    }
    public private (set) var turnOrder: Int = 0

    var name : String!
    var asset : String?
    var cash : Int {
        return self.wallet.balance
    }
    var isAI : Bool = true
    var wallet : Wallet = Wallet()

    // Hand of cards
    lazy var hand : Hand = Hand(owner: self)

    // SalesBook
    lazy var salesBook : SalesBook = SalesBook(owner: self)

    init(name: String, isAI: Bool = true, asset: String? = nil) {
        self.name = name
        self.isAI = isAI
        if let asset = asset {
            self.asset = asset
        }
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Player.init(name: self.name, isAI: self.isAI, asset: self.asset)
        copy.wallet = self.wallet.copy(with: zone) as! Wallet
        copy.playerId = self.playerId
        copy.hand = self.hand.copy(with: zone) as! Hand
        copy.salesBook = self.salesBook.copy(with: zone) as! SalesBook
        return copy
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

    func setTurnOrderIndex(_ value: Int) {
        self.turnOrder = value
    }

    public static func sortByHighestCash(_ players: [Player]) -> [Player] {
        return players.sorted { (p1, p2) -> Bool in
            return p1.cash > p2.cash
        }
    }

    public static func sortByLowestCash(_ players: [Player]) -> [Player] {
        return players.sorted { (p1, p2) -> Bool in
            return p1.cash < p2.cash
        }
    }
}

