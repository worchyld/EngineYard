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
    
    func preparePlayers(players: [Player]) {
        self.players = players
    }
    
    func prepareBoard() {
        guard let players = self.players else {
            return
        }
        self.board = Board()
        self.board!.prepare(for: players.count)
    }
}
