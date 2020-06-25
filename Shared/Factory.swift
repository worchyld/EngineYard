//
//  Factory.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Locomotive factory
struct Factory: Codable, Identifiable {
    let id: UUID
    let avatar: String
    let cost: Int
    var initialOrder: Int?
    var existingOrders, completedOrders: [Int]?
    var cards: [Card]?
    var available: Bool
    let livery: Livery
    let generation: Generation
    var rusting: Rusting
    let orderCapacity: Int
    internal var references: [Reference]?

    // MARK: - Child Reference
    struct Reference: Codable {
        var id: String
    }
}


extension Factory {
    static func == (lhs: Factory, rhs: Factory) -> Bool {
        return (lhs.id == rhs.id)
    }
}
