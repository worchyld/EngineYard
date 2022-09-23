//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 22/03/2022.
//

import Foundation

public enum HandError: Error {
    case doNotOwnThisCard
    case alreadyHaveThisCard
    case cannotOwnAnotherCardFromThisGeneration
}

class Hand {
    public private (set) var cards: [Card] = [Card]()
        
    func push(_ card: Card) {
        self.cards.append(card)
    }
    
    func pop(_ card: Card) {
        self.cards.removeObject(object: card)
    }
}

// MARK: Adding card to hand validation

extension Hand {
    // Does this card already exist in your hand?
    internal func seek(_ card: Card) -> Bool {
        guard let _ = (self.cards.filter {
            $0.name == card.name
        }.first) else {
            return false
        }
        return true
    }
    
    // A player can only have 1 card per generation & colour
    internal func seekSameGenerationAndColour(_ card: Card) -> Bool {
        guard let _ = (self.cards.filter {
            $0.generation == card.generation &&
            $0.livery == card.livery
        }.first) else {
            return false
        }
        return true
    }
    
    internal func canPush(_ card: Card) throws -> Bool {
        guard self.seek(card) else {
            throw HandError.alreadyHaveThisCard
        }
        guard self.seekSameGenerationAndColour(card) else {
            throw HandError.cannotOwnAnotherCardFromThisGeneration
        }
        return true
    }
    
    internal func canPop(_ card: Card) throws -> Bool {
        guard self.seek(card) else {
            throw HandError.doNotOwnThisCard
        }
        return true
    }
}
