//
//  BoardPosition.swift
//  EngineYard
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct BoardPosition: Identifiable, FamilyProtocol {
    let id: Int
    var color: Family.Color
    var generation: Family.Generation
    var name: String {
        return ("\(self.color).\(self.generation)")
    }
    let orderCapacity: Int
    var cards: [Card] = [Card]()
    var orders: [Int]

    enum State: Int, CaseIterable {
        case unavailable, available, rusting, rusted
    }
    var state: BoardPosition.State = .unavailable

    init(_ id: Int = 0, color: Family.Color, generation: Family.Generation, orderCapacity: Int) {
        self.id = id
        self.color = color
        self.generation = generation
        self.orderCapacity = orderCapacity
        self.orders = [Int]()
        self.orders.reserveCapacity(orderCapacity)
    }
}

extension BoardPosition {
    fileprivate mutating func setCards(cards: [Card]) {
        print ("setCards is called")
        self.cards = cards
    }
}

extension BoardPosition : CustomStringConvertible {
    var description: String {
        return ("id: \(id), name: \(name), state: \(state), capacity: \(orderCapacity), # cards:\(cards.count)")
    }
}
