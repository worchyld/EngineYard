//
//  Board.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation

final class Board {
    var players: [Player] = [Player]()
    var activePlayer: Player? = nil
    var activePlayerIndex: Int = 0
    
    var spaces: [Space] = [Space]()
    
    init(spaces: [Space]) {
        self.spaces = spaces
    }
    
    func unlockSpace() {
        // TBD
    }
}

final class Space {
    public private (set) var loco: Locomotive
    
    init(loco: Locomotive) {
        self.loco = loco
    }
}
