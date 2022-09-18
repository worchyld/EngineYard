//
//  DicePoolManager.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation

public enum OrderType: Int {
    case order, sale
}

class DicePoolManager {
    private var deck: Deck
    
    init(deck: Deck) {
        self.deck = deck
    }
}
