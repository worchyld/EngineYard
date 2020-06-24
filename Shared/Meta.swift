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
    var factories, totalCapacity: Int
    var cards: Meta.Cards

    enum CodingKeys: String, CodingKey {
        case factories
        case totalCapacity = "total-capacity"
        case cards
    }

    // MARK: - Meta:Cards totals
    struct Cards: Codable {
        var total: Int
        var green, red, yellow, blue: Meta.Generations
    }

    // MARK: - Meta:Generations/Livery totals
    struct Generations: Codable {
        var total: Int
        var generations: [Int]
    }

}
