//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 22/03/2022.
//

import Foundation

class Hand {
    public private (set) var cards: [Card] = [Card]()
        
    func push(_ card: Card) {
        
    }
    
    func pop(_ card: Card) {
        
    }
}

// MARK: Adding card to hand validation

extension Hand {
    func canPush(_ card: Card) -> Bool {
        return true
    }
    
    func canPop(_ card: Card) -> Bool {
        return true
    }
}
