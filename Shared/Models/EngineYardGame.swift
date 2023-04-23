//
//  EngineYardGame.swift
//  EngineYard
//
//  Created by Amarjit on 23/04/2023.
//

import Foundation

enum GamePhase: Int, Codable, CaseIterable, Equatable {
    case mainMenu, playerSelect, buyTrainScreen, buyProductionScreen, sellScreen, marketUpdateScreen, taxScreen, endOfGameScreen
}

enum GameState: Int, Codable, Equatable {
    case setup, playing, paused, end
}

class EngineYardGame {
    var board: Board
    var gameState: GameState = .setup
    var gamePhase: GamePhase = .mainMenu
    var gameMessages: [GameMessage] = [GameMessage]()
    
    init(board: Board, gameState: GameState, gamePhase: GamePhase, gameMessages: [GameMessage]) {
        self.board = board
        self.gameState = gameState
        self.gamePhase = gamePhase
        self.gameMessages = gameMessages
    }
}
