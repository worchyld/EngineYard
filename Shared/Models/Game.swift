//
//  Game.swift
//  EngineYard
//
//  Created by Amarjit on 28/05/2022.
//

import Foundation

final class Game {
    public private(set) var players: [Player]?
    public private(set) var gamePhase: GamePhase = .setup
    public private(set) var board: Board?
    
    init(players: [Player]? = nil, gamePhase: GamePhase = .setup, board: Board? = nil) {
        self.players = players
        self.gamePhase = gamePhase
        self.board = board
    }
}

extension Game {
    func setGamePhase(_ phase: GamePhase) {
        self.gamePhase = phase
    }
    func setPlayers(_ players: [Player]) {
        self.players = players
    }
    func setBoard(_ board: Board) {
        self.board = board
    }
}
