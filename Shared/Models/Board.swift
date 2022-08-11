//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 29/05/2022.
//

import Foundation

class Board {
    public private (set) var space: [BoardSpace] = [BoardSpace]()
}

extension Board {
    func prepare() {
//        let board = Board()
//        
//        let cardsGen1 = [
//            Card.init(name: "Green.1", image: .greenTrain, cost: 4, livery: .green, generation: .first, trainPool: 4, maxDice: 3),
//            Card.init(name: "Green.1", image: .greenTrain, cost: 4, livery: .green, generation: .first, trainPool: 4, maxDice: 3),
//            Card.init(name: "Green.1", image: .greenTrain, cost: 4, livery: .green, generation: .first, trainPool: 4, maxDice: 3),
//            Card.init(name: "Green.1", image: .greenTrain, cost: 4, livery: .green, generation: .first, trainPool: 4, maxDice: 3)
//        ]
    }
}

class BoardSpace {
    var deck: [Card] = [Card]()
    var active: Bool = false
}
