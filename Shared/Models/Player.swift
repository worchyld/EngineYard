//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum PlayerState: Int {
    case inactive
    case active
    case thinking
}

class Player {
    private let uuid: String = UUID().uuidString
    let name: String
    public private (set) var cash: Int = 0
    public private (set) var isAI: Bool = true

    init(name: String) {
        self.name = name
    }
}
