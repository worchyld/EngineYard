//
//  Meta.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// MARK: - Meta
struct Meta: Codable {
    var spaces, totalCapacity: Int
    var cards: Meta.Cards

    enum CodingKeys: String, CodingKey {
        case spaces
        case totalCapacity = "total-capacity"
        case cards
    }

    // MARK: - Cards
    struct Cards: Codable {
        var total: Int
        var green, red, yellow, blue: Meta.Generations
    }

    // MARK: - Generations/Livery totals
    struct Generations: Codable {
        var total: Int
        var generations: [Int]
    }

}
