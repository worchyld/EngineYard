//
//  Order.swift
//  EngineYard
//
//  Created by Amarjit on 24/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Order model
struct Order: Identifiable, Codable {
    let id: UUID
    let value: Int

    enum CodingKeys: String, CodingKey {
        case id, value
    }

    init(id: UUID = UUID(), value: Int = 0) {
        self.id = id
        self.value = value
    }
}
