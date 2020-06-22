//
//  Locomotive.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias Card = Locomotive

// MARK: - Locomotive
struct Locomotive: Codable {
    var id, ref, name, avatar: String?
    var cost: Int?, color, generation: Int?
    var livery: Livery?

    enum CodingKeys: CodingKey {
        case id, ref, name, avatar, cost, generation
    }
}
