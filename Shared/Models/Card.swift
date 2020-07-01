//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 01/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct Card : Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let avatar: String
    let cost: Int
    let livery: Livery
    let generation: Generation

    var production: Int
    var spentProduction: Int

    //var factory: Factory?
    //var owner: Player?

    // codingkeys
    private enum CodingKeys: String, CodingKey {
        case id, name, avatar, cost, livery, generation
        case production, spentProduction
    }
}

extension Card {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        avatar = try container.decode(String.self, forKey: .avatar)
        cost = try container.decode(Int.self, forKey: .cost)
        livery = try container.decode(Livery.self, forKey: .livery)
        generation = try container.decode(Generation.self, forKey: .generation)
        production = try container.decodeIfPresent( Int.self , forKey: .production) ?? 0
        spentProduction = try container.decodeIfPresent( Int.self , forKey: .spentProduction) ?? 0
    }
}

extension Card {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return (lhs.id == rhs.id)
    }
}
