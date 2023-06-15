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
    
    var spaces: [Locomotive] = [Locomotive]()
    
    init(spaces: [Locomotive]) {
        self.spaces = spaces
    }
    
}

extension Board {

}
