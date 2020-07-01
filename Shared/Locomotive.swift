//
//  Locomotive.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias Card = Card

// MARK: - Locomotive
struct Card: Codable, Identifiable, Hashable, Equatable {
    let id: UUID
    let name, avatar: String
    let cost: Int, generation: Generation
    let livery: Livery
    var production: Int
    var spentProduction: Int
}

extension Card {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return (lhs.id == rhs.id)
    }
}

extension Card {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        avatar = try container.decode(String.self, forKey: .avatar)
        cost = try container.decode(Int.self, forKey: .cost)
        generation = try container.decode(Generation.self, forKey: .generation)
        livery = try container.decode(Livery.self, forKey: .livery)
    }
}
