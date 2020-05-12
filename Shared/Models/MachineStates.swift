//
//  MachineStates.swift
//  EngineYard
//
//  Created by Amarjit on 12/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Unfinished, probably not to be used
enum MachineState: Int {
    case gameSetup = 0
    case playerTurn
    case nextPlayer
    case gameEnd
}

enum MainGamePhases: Int {
    case notStarted = 0
    case buyLocomotive
    case buyProduction
    case selling
    case payTaxes
    case marketDemands
}
