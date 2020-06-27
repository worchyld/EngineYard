//
//  Factory.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation


// MARK: - Factory
struct Factory: Codable {
    let id: UUID
    let name, avatar: String
    let cost: Int
    let livery: Livery
    let generation: Generation
    var cards: [Card]?
    var available: Bool
    var rusting: Rusting
    let maxDice: Int
}

// MARK: - Card
struct Card: Codable, ProductionInputDelegate {
    let id: UUID
    let name, avatar: String
    let cost: Int
    let generation: Generation
    let livery: Livery
    var production: Int
    var spentProduction: Int

    var productionCost: Int {
        guard (self.cost % 4 == 0) else { return 0 }
        return Int( floor(Double(self.cost / 2)) )
    }
    
    var income: Int {
        guard (cost % 4 == 0) else { return 0 }
        return Int( floor(Double(productionCost / 2)) )
    }

    init(id: UUID?, name: String, avatar: String, cost: Int, generation: Generation, livery: Livery ) {
        self.id = id ?? UUID()
        self.name = name
        self.avatar = avatar
        self.cost = cost
        self.generation = generation
        self.livery = livery
        self.production = 0
        self.spentProduction = 0
    }

    private enum CodingKeys: String, CodingKey {
        case id, name, avatar, cost, generation, livery
        case production, spentProduction
    }

}

extension Card {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        avatar = try container.decode(String.self, forKey: .avatar)
        let cost = try container.decode(Int.self, forKey: .cost).clamp(low: 4, high: 56)
        if ((cost % 4) != 0) {
            throw NSError(domain: "Cost is not a modulus of 4", code: 0, userInfo: nil)
        }
        guard (cost >= 4 && cost <= 56 ) else {
            throw NSError(domain: "Cost is not in the expected range of 4-56", code: 0, userInfo: nil)
        }
        self.cost = cost

        livery = try container.decode(Livery.self, forKey: .livery)
        generation = try container.decode(Generation.self, forKey: .generation)
        production = try container.decodeIfPresent(Int.self, forKey: .production) ?? 0
        spentProduction = try container.decodeIfPresent(Int.self, forKey: .spentProduction) ?? 0
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(avatar, forKey: .avatar)
        try container.encode(cost, forKey: .cost)
        try container.encode(livery, forKey: .livery)
        try container.encode(generation, forKey: .generation)
        try container.encode(production, forKey: .production)
        try container.encode(spentProduction, forKey: .spentProduction)
    }
}

extension Card {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return (lhs.id == rhs.id)
    }
    static func != (lhs: Card, rhs: Card) -> Bool {
        return (lhs.id != rhs.id)
    }
}




extension Factory {
    static func == (lhs: Factory, rhs: Factory) -> Bool {
        return (lhs.id == rhs.id)
    }
}

