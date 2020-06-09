//
//  Order.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Each deck has `orders` and `sales`
// Both are represented by Int/Dice values in
//    a single array
struct Order {
    enum State: Int {
        case unowned
        case existingOrder
        case sold
    }
    var value: Int?
    var state: Order.State = .unowned

    init(_ state: Order.State = .existingOrder) {
        self.value = self.generateOrder()
        self.state = state
    }
}

extension Order {
    func generateOrder() -> Int {
        return Die.roll
    }
}

extension Order {
    static func canAdd(_ state: Order.State = .existingOrder, to deck: Deck) -> Bool {
        let capacity = deck.orderCapacity

        

        return true
    }
}
