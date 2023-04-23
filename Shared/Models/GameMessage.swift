//
//  GameMessage.swift
//  EngineYard
//
//  Created by Amarjit on 23/04/2023.
//

import Foundation

enum GameMessageCategory: Int {
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
