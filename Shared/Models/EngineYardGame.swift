//
//  EngineYardGame.swift
//  EngineYard
//
//  Created by Amarjit on 23/04/2023.
//

import Foundation

enum GamePhase: Int, Codable, CaseIterable, Equatable {
    case setup, mainMenu, playerSelect, buyTrainScreen, buyProductionScreen, sellScreen, marketUpdateScreen, taxScreen, endOfGameScreen
}

public enum GameErrorDelegate: Error {
    case noGameData, noGameObject, noBoardDefined, invalidBoardData, noPlayerFound, invalidPlayerCount
}

typealias Game = EngineYardGame


class EngineYardGame {
    public private(set) var board: Board
    public private(set) var gamePhase: GamePhase
    var players: [Player] = [Player]()
    var firstPlayer: Player?
    var currentPlayer: Player?
    
    init(board: Board, players: [Player]) {
        self.board = board
        self.players = players
        self.gamePhase = .setup
    }
    
    func setGamePhase(to phase: GamePhase) {
        self.gamePhase = phase
    }
    func setBoard(to board: Board) {
        self.board = board
    }
}
