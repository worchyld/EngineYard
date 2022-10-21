//
//  GamePhase.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import Foundation

// GamePhase
public enum GamePhase : NSInteger, CaseIterable, Codable {
    case setup, mainMenu, pickPlayers, buyTrain, buyProduction, sales, payTaxes, marketDemands, winnerDeclared
}
