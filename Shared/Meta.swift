//
//  Meta.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct Meta: Codable {
    var spaces, totalCapacity, cards: Int
    var liveries: Meta.Liveries
    var generations: Meta.Generations

    enum CodingKeys: String, CodingKey {
        case spaces
        case totalCapacity = "total-capacity"
        case cards, liveries, generations
    }


    // MARK: - Generations
    struct Generations: Codable {
        var first, second, third, fourth: Meta.Liveries
        var fifth: Meta.Liveries
    }

    // MARK: - Liveries
    struct Liveries: Codable {
        var total, green, red, yellow: Int
        var blue: Int
    }

}

