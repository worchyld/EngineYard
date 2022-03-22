//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import Foundation

class BoardSpace {
    var available: Bool = false
    var deck: [Card] = [Card]()
    
    init(with deck:[Card]) {
        self.deck = deck
    }
    
    func toggleAvailability() {
        self.available = !self.available
    }
    
    func makeNextSpaceAvailable() {
        // TBD
    }
}

class Board {
    private (set) var spaces: [BoardSpace] = [BoardSpace]()
}
