//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// The board is a collection of `Locomotives`; each with cards
class Locomotive: Identifiable, FamilyDelegate {
    let id: UUID = UUID()
    let name: String
    let family: Family
    var category: Family.Category { return self.family.category }
    var color: Family.Color { return self.family.color }
    var generation: Family.Generation { return self.family.generation }
    let cost: Int
    var cards: [Card] = [Card]()

    // Orders
    let orderCapacity: Int
    var orders: [Order] = [Order]() {
        didSet {
            changeState(to: .existing)
        }
    }

    enum State: Int, CaseIterable {
       case unavailable, existing, old, obsolete
    }
    var state: Locomotive.State = Locomotive.State.unavailable

    init(_ name: String, _ cost: Int, _ color: Family.Color, _ generation: Family.Generation, _ orderCapacity: Int) {
        self.name = name
        self.cost = cost
        self.family = Family(color: color, generation: generation)
        self.orderCapacity = orderCapacity
        self.orders.reserveCapacity(orderCapacity)
        //self.orders = Array<Order?>(repeating: nil, count: orderCapacity)
    }
}

extension Locomotive {
    private func changeState(to: Locomotive.State) {
        self.state = to
    }
}
