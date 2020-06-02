//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// : Represents the gameboard
// The gameboard has a number of positions.
// Each position holds a stack/array/collection of cards
// A position has a `state`
struct Board {
    private(set) var positions: [BoardPosition]

    init() {
        self.positions = Board.create()
    }
}
