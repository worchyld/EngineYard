//
//  GamePhase.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import Foundation

// GamePhase
enum GamePhase : NSInteger, CaseIterable, Codable {
    case mainMenu, pickPlayers, buyTrain, buyProduction, sellProduction, payTaxes, marketDemands, winnerDeclared
}
