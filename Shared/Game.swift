//
//  Game.swift
//  EngineYard
//
//  Created by Amarjit on 20/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// Game

class Game : NSObject {
    static var instance = Game()
    var board: GameBoard?
    var dateCreated: Date?

    override init() {
        super.init()
        self.setup()
    }
}

extension Game {

    func setup() {
        self.board = GameBoard()

    }

}
