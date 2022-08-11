//
//  Game.swift
//  EngineYard
//
//  Created by Amarjit on 28/05/2022.
//

import Foundation

class Game {
    var board: Board?
    var players: [Player]?
    var gamePhase: GamePhase = .setup
}

extension Game {
    func prepareBoard() {
        self.board = Board()
        self.board?.prepare()
    }
}
