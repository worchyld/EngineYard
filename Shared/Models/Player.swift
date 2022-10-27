//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 08/03/2022.
//

import Foundation
import GameplayKit

public enum PlayerState: Int {
    case waiting = 0, thinking, done
}

enum CardAction {
    case push(card: Card)
    case pop(card: Card)
    case seek(card: Card)
}

class Player: NSObject, GKGameModelPlayer {
    var playerId: Int = 0
    
    var name : String = ""
    var avatar : String = ""
    private var cash : Int = 0
    public var balance: Int {
        return self.cash
    }
    public private (set) var state : PlayerState = .waiting
    public private (set) var onTurn : Bool = false 
    
    private var _portfolio = Portfolio()
    public var hand: [Card] {
        return self._portfolio.hand
    }
}

extension Player {
    public func setCash(balance: Int = 0) {
        guard (balance >= 0) else { return }
        self.cash = balance
    }
    
    public func handleCardAction(card: Card, action: CardAction) -> Result<Bool, PortfolioError> {
        return self._portfolio.handleCardAction(action: action)
    }
}
