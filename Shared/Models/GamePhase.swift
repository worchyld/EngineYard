//
//  GamePhase.swift
//  EngineYard
//
//  Created by Amarjit on 14/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum GamePhase : NSInteger, CaseIterable, Codable {
    case mainMenu, pickPlayers, buyTrain, buyProduction, sellProduction, payTaxes, marketDemands, winnerDeclared
}
