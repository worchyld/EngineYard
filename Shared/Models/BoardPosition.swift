//
//  BoardPosition.swift
//  EngineYard
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class BoardPosition: Identifiable, FamilyProtocol {
    let id: Int
    var color: Family.Color
    var generation: Family.Generation
    var name: String {
        return ("\(self.color).\(self.generation)")
    }
    let cost: Int
    let orderCapacity: Int
    var cards: [Card] = [Card]()
    var dice: [Int] // orders go here

    enum State: Int, CaseIterable {
        case unavailable, available, old, obsolete
    }
    var state: BoardPosition.State = .unavailable

    init(_ id: Int = 0, cost: Int, color: Family.Color, generation: Family.Generation, orderCapacity: Int) {
        self.id = id
        self.color = color
        self.cost = cost
        self.generation = generation
        self.orderCapacity = orderCapacity
        self.dice = [Int]()
        self.dice.reserveCapacity(orderCapacity)
    }
}

extension BoardPosition {
    /*
    fileprivate mutating func setCards(cards: [Card]) {
        print ("setCards is called")
        self.cards = cards
    }*/
    func setCards(cards: [Card]) {
        print ("setCards is called")
        self.cards = cards
    }
}

extension BoardPosition : CustomStringConvertible {
    var description: String {
        return ("id: \(id), name: \(name), state: \(state), capacity: \(orderCapacity), # cards:\(cards.count)")
    }
}
