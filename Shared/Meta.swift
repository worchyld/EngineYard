//
//  Meta.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct Meta: Codable {
    var boardSpaces: Int?
    var cards: Meta.Cards?

    enum CodingKeys: String, CodingKey {
        case boardSpaces = "board-spaces"
        case cards
    }

    // MARK: - Cards
    struct Cards: Codable {
        var total: Int?
        var liveries: Meta.Liveries?
        var generations: Meta.Generations?
    }

    // MARK: - Colors/Liveries
    struct Liveries: Codable {
        var green, red, yellow, blue: Int?
        var total: Int?
    }

    // MARK: - Generations
    struct Generations: Codable {
        var first, second, third, fourth: Meta.Liveries?
        var fifth: Meta.Liveries?
    }
}


