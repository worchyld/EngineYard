//
//  GameBoard.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

extension GameModel {
    func prepare() -> [Deck] {
        let decks = [
            Deck.init(name: "Green.1", cost: 4, generation: .first, color: .green, capacity: 3, numberOfChildren: 4)
            , Deck.init(name: "Red.1", cost: 8, generation: .first, color: .red, capacity: 3, numberOfChildren: 3)
            , Deck.init(name: "Yellow.1", cost: 12, generation: .first, color: .yellow, capacity: 2, numberOfChildren: 2)
            , Deck.init(name: "Blue.1", cost: 16, generation: .first, color: .blue, capacity: 1, numberOfChildren: 1)
            , Deck.init(name: "Green.2", cost: 20, generation: .second, color: .green, capacity: 4, numberOfChildren: 4)
            , Deck.init(name: "Red.2", cost: 24, generation: .second, color: .red, capacity: 3, numberOfChildren: 3)
            , Deck.init(name: "Yellow.2", cost: 28, generation: .second, color: .yellow, capacity: 3, numberOfChildren: 2)
            , Deck.init(name: "Green.3", cost: 32, generation: .third, color: .green, capacity: 4, numberOfChildren: 4)
            , Deck.init(name: "Blue.2", cost: 36, generation: .second, color: .blue, capacity: 2, numberOfChildren: 2)
            , Deck.init(name: "Red.3", cost: 40, generation: .third, color: .red, capacity: 4, numberOfChildren: 3)
            , Deck.init(name: "Green.4", cost: 44, generation: .fourth, color: .green, capacity: 5, numberOfChildren: 4)
            , Deck.init(name: "Yellow.3", cost: 48, generation: .third, color: .yellow, capacity: 3, numberOfChildren: 3)
            , Deck.init(name: "Red.4", cost: 52, generation: .fourth, color: .red, capacity: 4, numberOfChildren: 4)
            , Deck.init(name: "Green.5", cost: 56, generation: .fifth, color: .green, capacity: 5, numberOfChildren: 4)
        ]

        return decks
    }
}

        // add deck subscriber
//        let _ = decks.map({
//            $0.addSubscriber(self)
//        })
