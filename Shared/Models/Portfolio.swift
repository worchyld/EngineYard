//
//  Portfolio.swift
//  EngineYard
//
//  Created by Amarjit on 21/10/2022.
//

import Foundation

enum PortfolioError : Error {
    case locoCannotBeFound
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
    func canAdd(card: Card) -> Result<Bool, PortfolioError> {
        do {
            try validateAdd(card: card)
            
            return .success(true)
        } catch let err {
            return .failure(err as! PortfolioError)
        }
    }
    
    func add(card: Card) -> Result<Bool, PortfolioError> {
        switch canAdd(card: card) {
        case .success(_):
            self._hand.append(card)
            return .success(true)
            
        case .failure(let err):
            return .failure(err as PortfolioError)
        }
    }
    
    
    private func validateAdd(card: Card) throws {
        guard let loco = card.loco else {
            throw PortfolioError.locoCannotBeFound
        }
        guard loco.rust != .rusted else {
            throw PortfolioError.locoHasRusted
        }
        guard loco.rust != .active else {
            throw PortfolioError.locoCannotBeActive
        }
        if let _ = seek(card: card) {
            throw PortfolioError.alreadyOwnThisCard(card: card)
        }
        if let _ = seekCardWithSameGeneration(as: card) {
            throw PortfolioError.cannotOwnCardFromSameDeck
        }
    }
    
    
    func canRemove(card: Card) {}
    func remove(card: Card) {}
    
    // MARK: (Private) methods
    
    
    private func seek(card: Card) -> Card? {
        return self.hand.filter { item in
            return (card == item)
        }.first
    }
    
    private func seekCardWithSameGeneration(as card: Card) -> Card? {
        let results = self.hand.filter { item in
            return (card.loco!.generation ==  item.loco!.generation)
        }.first
        return results
    }
}
