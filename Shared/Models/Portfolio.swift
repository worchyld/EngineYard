//
//  Portfolio.swift
//  EngineYard
//
//  Created by Amarjit on 21/10/2022.
//

import Foundation

enum PortfolioError : Error {
    case locoCannotBeActive
    case locoHasRusted
    case alreadyOwnThisCard(card: Card)
    case cannotOwnCardFromSameDeck
    case cardNotFoundInPortfolio(card: Card)
}

// Player hand management
final class Portfolio {
    private var _hand: [Card]
    public var hand: [Card] {
        return self._hand
    }
    
    init(_hand: [Card] = [Card]()) {
        self._hand = _hand
    }
}

extension Portfolio {
    func canAdd(card: Card) -> Bool {
        return true
    }
    
    func add(card: Card) {
    }
}
