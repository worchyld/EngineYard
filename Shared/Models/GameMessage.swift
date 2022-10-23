//
//  GameMessage.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation

public enum GameMessageCategory: Int {
    case error, warning, success, status
}

struct GameMessage {
    static let shared = GameMessage()

    let category: GameMessageCategory
    let message: String
    
    private init(message: String = "", category: GameMessageCategory = .status) {
        self.message = message
        self.category = category
    }
}
