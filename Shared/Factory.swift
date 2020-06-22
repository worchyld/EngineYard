//
//  Factory.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// MARK: - Factory
struct Factory: Codable {
    var id, ref, avatar: String?
    var cost, livery, generation, initialOrder: Int?
    var existingOrders, completedOrders, cards: [JSONAny]?
    var state, orderCapacity: Int?
}
