//
//  GameLogEntry.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation

public enum GameLogType: Int {
    case error, warning, success, status
}

struct GameLogEntry {
    let type: GameLogType = .status
    let message: String
}
