//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 22/03/2022.
//

import Foundation

class Hand {
    private (set) var cards: [Card] = [Card]()
    
    func add(_ card: Card) {
        
    }
    
    func remove(_ card: Card) {
        
    }
}

extension Hand {
    func canAdd(_ card: Card) -> Bool {
        return true
    }
    
    func canRemove(_ card: Card) -> Bool {
        return true
    }
}
