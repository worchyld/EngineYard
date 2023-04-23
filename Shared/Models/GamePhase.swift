//
//  GamePhase.swift
//  EngineYard
//
//  Created by Amarjit on 23/04/2023.
//

import Foundation

enum GamePhase: Int, Codable, CaseIterable, Equatable {
    case mainMenu, playerSelect, buyTrainScreen, buyProductionScreen, sellScreen, marketUpdateScreen, taxScreen, endOfGameScreen
}
