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
        var colors: Meta.Colors?
        var generations: Meta.Generations?
    }

    // MARK: - Colors
    struct Colors: Codable {
        var green, red, yellow, blue: Int?
        var total: Int?
    }

    // MARK: - Generations
    struct Generations: Codable {
        var first, second, third, fourth: Meta.Colors?
        var fifth: Meta.Colors?
    }
}


