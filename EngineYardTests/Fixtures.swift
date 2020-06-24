//
//  Fixtures.swift
//  EngineYardTests
//
//  Created by Amarjit on 24/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

@testable import EngineYard
import  XCTest

struct Fixtures {
    static var locomotives: [Locomotive] {
        let greenFirst = Locomotive(id: "green.1", ref: "green.1", name: "green.1", avatar: "green-1.png", cost: 4, generation: .first, livery: .green)
        let redFirst = Locomotive(id: "red.1", ref: "red.1", name: "red.1", avatar: "red-1.png", cost: 8, generation: .first, livery: .red)
        let yellowFirst = Locomotive(id: "yellow.1", ref: "yellow.1", name: "yellow.1", avatar: "yellow-1.png", cost: 12, generation: .first, livery: .yellow)
        let blueFirst = Locomotive(id: "blue.1", ref: "blue.1", name: "blue.1", avatar: "blue-1.png", cost: 18, generation: .first, livery: .blue)

        return [greenFirst, redFirst, yellowFirst, blueFirst]
    }

    static var factories: [Factory] {
        let greenFirst = Factory(id: "green.1", ref: "green.1", avatar: "green.1", cost: 4, initialOrder: 0, existingOrders: [nil], completedOrders: [nil], cards: [nil], available: false, livery: .green, generation: .first, rusting: Rusting.notRusting, orderCapacity: 3)
        let redFirst = Factory(id: "green.1", ref: "green.1", avatar: "green.1", cost: 4, initialOrder: 0, existingOrders: [nil], completedOrders: [nil], cards: [nil], available: false, livery: .green, generation: .first, rusting: Rusting.notRusting, orderCapacity: 3)
        let yellowFirst = Factory(id: "yellow.1", ref: "yellow.1", avatar: "yellow.1", cost: 12, initialOrder: 0, existingOrders: [nil], completedOrders: [nil], cards: [nil], available: false, livery: .blue, generation: .first, rusting: Rusting.notRusting, orderCapacity: 3)
        let blueFirst = Factory(id: "blue.1", ref: "blue.1", avatar: "blue.1", cost: 18, initialOrder: 0, existingOrders: [nil], completedOrders: [nil], cards: [nil], available: false, livery: .blue, generation: .first, rusting: Rusting.notRusting, orderCapacity: 3)

        return [greenFirst, redFirst, yellowFirst, blueFirst]
    }
}

public func example(of description: String,
                    _ action: () -> Void) {
    print("\n", description, "")
    action()
}
