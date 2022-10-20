//
//  GameNotification.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation

public enum GameNotificationCategory: Int {
    case error, warning, success, status
}

struct GameNotification {
    let category: GameNotificationCategory
    let message: String
    
    init(message: String, category: GameNotificationCategory = .status) {
        self.message = message
        self.category = category
    }
}
