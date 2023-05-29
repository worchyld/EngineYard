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
    case noGameData, noGameObject, noBoardDefined, noPlayerFound, notAValidPlayerCount
}

typealias Game = EngineYardGame


class EngineYardGame {
    public private(set) var board: Board
    public private(set) var gamePhase: GamePhase = .mainMenu
    
    init(board: Board, gamePhase: GamePhase) {
        self.board = board
        self.gamePhase = gamePhase
    }
    
    func setGamePhase(to phase: GamePhase) {
        self.gamePhase = phase
    }
    func setBoard(to board: Board) {
        self.board = board
    }
}
