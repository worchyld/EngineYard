//
//  Board.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation

final class Board {
    var spaces: [Space] = [Space]()
}

final class Space {
    private var loco: Locomotive
    
    init(loco: Locomotive) {
        self.loco = loco
    }
}
