//
//  Game.swift
//  EngineYard
//
//  Created by Amarjit on 20/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// Game
final class Game : NSObject {
    var board: Board!
    var players: [Player] = [Player]()
    var dateCreated: Date?

    init(players: [Player]) {
        super.init()
        self.board = Board()
        self.players = players
    }
}
