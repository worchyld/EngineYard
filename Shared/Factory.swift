//
//  Factory.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct Factory: Codable {
    var id, ref, avatar: String?
    var cost, initialOrder: Int?
    var existingOrders, completedOrders: [Int?]
    var cards: [Locomotive?]?
    var available: Bool?
    var livery: Livery?
    var generation: Generation?
    var rusting: Rusting?
    var orderCapacity: Int?
}
