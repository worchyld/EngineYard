//
//  Card+Builder.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Builds an array of Cards used in the game
extension Card {

    static func build() -> [Card] {

         let cards = [
            
            // Green.first (x4)
            Card.init(name: "Green.1", cost: 4, color: .green, generation: .first),
            Card.init(name: "Green.1", cost: 4, color: .green, generation: .first),
            Card.init(name: "Green.1", cost: 4, color: .green, generation: .first),
            Card.init(name: "Green.1", cost: 4, color: .green, generation: .first),

            // Red.first (x3)
            Card.init(name: "Red.1", cost: 8, color: .red, generation: .first),
            Card.init(name: "Red.1", cost: 8, color: .red, generation: .first),
            Card.init(name: "Red.1", cost: 8, color: .red, generation: .first),

            // Yellow.first (x2)
            Card.init(name: "Yellow.1", cost: 12, color: .yellow, generation: .first),
            Card.init(name: "Yellow.1", cost: 12, color: .yellow, generation: .first),

            // Blue.first (x1)
            Card.init(name: "Blue.1", cost: 16, color: .blue, generation: .first),

            // Green.second (x4)
            Card.init(name: "Green.2", cost: 20, color: .green, generation: .second),
            Card.init(name: "Green.2", cost: 20, color: .green, generation: .second),
            Card.init(name: "Green.2", cost: 20, color: .green, generation: .second),
            Card.init(name: "Green.2", cost: 20, color: .green, generation: .second),

            // Red.second (x3)
            Card.init(name: "Red.2", cost: 24, color: .red, generation: .second),
            Card.init(name: "Red.2", cost: 24, color: .red, generation: .second),
            Card.init(name: "Red.2", cost: 24, color: .red, generation: .second),

            // Yellow.second (x2)
            Card.init(name: "Yellow.2", cost: 28, color: .yellow, generation: .second),
            Card.init(name: "Yellow.2", cost: 28, color: .yellow, generation: .second),

            // Green.third (x4)
            Card.init(name: "Green.3", cost: 32, color: .green, generation: .third),
            Card.init(name: "Green.3", cost: 32, color: .green, generation: .third),
            Card.init(name: "Green.3", cost: 32, color: .green, generation: .third),
            Card.init(name: "Green.3", cost: 32, color: .green, generation: .third),

            // Blue.second (x2)
            Card.init(name: "Blue.2", cost: 36, color: .blue, generation: .second),
            Card.init(name: "Blue.2", cost: 36, color: .blue, generation: .second),

            // Red.third (x3)
            Card.init(name: "Red.3", cost: 40, color: .red, generation: .third),
            Card.init(name: "Red.3", cost: 40, color: .red, generation: .third),
            Card.init(name: "Red.3", cost: 40, color: .red, generation: .third),

            // Green.fourth (x4)
            Card.init(name: "Green.4", cost: 44, color: .green, generation: .fourth),
            Card.init(name: "Green.4", cost: 44, color: .green, generation: .fourth),
            Card.init(name: "Green.4", cost: 44, color: .green, generation: .fourth),
            Card.init(name: "Green.4", cost: 44, color: .green, generation: .fourth),

            // Yellow.third (x3)
            Card.init(name: "Yellow.3", cost: 48, color: .yellow, generation: .third),
            Card.init(name: "Yellow.3", cost: 48, color: .yellow, generation: .third),
            Card.init(name: "Yellow.3", cost: 48, color: .yellow, generation: .third),

            // Red.fourth (x4)
            Card.init(name: "Red.4", cost: 52, color: .red, generation: .fourth),
            Card.init(name: "Red.4", cost: 52, color: .red, generation: .fourth),
            Card.init(name: "Red.4", cost: 52, color: .red, generation: .fourth),
            Card.init(name: "Red.4", cost: 52, color: .red, generation: .fourth),

            // Green.fifth (x4)
            Card.init(name: "Green.5", cost: 56, color: .green, generation: .fifth),
            Card.init(name: "Green.5", cost: 56, color: .green, generation: .fifth),
            Card.init(name: "Green.5", cost: 56, color: .green, generation: .fifth),
            Card.init(name: "Green.5", cost: 56, color: .green, generation: .fifth)
        ]

        return cards
    }
}
