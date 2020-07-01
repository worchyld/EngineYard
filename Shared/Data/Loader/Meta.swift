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
    var totalDecks, totalCapacity: Int
    var cards: Meta.Cards

    enum CodingKeys: String, CodingKey {
        case totalDecks
        case totalCapacity = "totalCapacity"
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

extension Meta {

    // Builder pattern. Used for internal integrity checks
    public static func build() -> Meta {
        let cards = Meta.Cards(total: 43, green: {
            return Generations(total: 20, generations: [4,4,4,4,4])
        }(), red: {
            return Generations(total: 13, generations: [3,3,3,4,0])
        }(), yellow: {
            return Generations(total: 7, generations: [2,2,3,0,0])
        }(), blue: {
            return Generations(total: 3, generations: [1,2,0,0,0])
        }())

        let meta = Meta.init(totalDecks: 14, totalCapacity: 46, cards: cards)
        return meta
    }

}
