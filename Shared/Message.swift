//
//  Message.swift
//  EngineYard
//
//  Created by Amarjit on 22/12/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// Generic message struct used for in-game messages, game-logs, etc

protocol MessageProtocol {
    var title: String? { get set }
    var message: String? { get set }
}

struct Message : MessageProtocol {
    var title: String?
    var message: String?

    init(title: String?, message: String?) {
        if let hasTitle = title {
            self.title = hasTitle
        }
        if let hasMessage = message {
            self.message = hasMessage
        }
    }
}
