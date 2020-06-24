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
    var id, ref, avatar: String
    var cost: Int
    var initialOrder: Int?
    var existingOrders, completedOrders: [Int?]
    var cards: [Locomotive?]?
    var available: Bool
    var livery: Livery
    var generation: Generation
    var rusting: Rusting
    var orderCapacity: Int
}


extension Factory {
    static func == (lhs: Factory, rhs: Factory) -> Bool {
        return (lhs.id == rhs.id)
    }
}
