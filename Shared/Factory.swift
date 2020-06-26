//
//  Factory.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Locomotive factory
struct Factory: Codable, Identifiable, Equatable, Hashable {
    let id: UUID
    let name: String
    let avatar: String
    let cost: Int
    var initialOrder: Int?
    var existingOrders, completedOrders: [Int]?
    var cards: [Card]?
    var available: Bool
    let livery: Livery
    let generation: Generation
    var rusting: Rusting
    let orderCapacity: Int
    internal var references: [Reference]?

    private enum CodingKeys: String, CodingKey {
        case id, name, avatar, cost, initialOrder, existingOrders, completedOrders, cards, available, livery, generation, rusting, orderCapacity, references
    }
}


// MARK: - Reference
struct Reference: Codable, Identifiable, Hashable, Equatable {
    var id: UUID

    private enum CodingKeys: String, CodingKey {
        case id
    }
}

extension Reference {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
    }
}


extension Factory {

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

        //initialOrder = try container.decodeIfPresent(Int.self, forKey: .initialOrder) ?? nil
        //existingOrders = try container.decodeIfPresent([Int].self, forKey: .existingOrders) ?? [Int]()
        //completedOrders = try container.decodeIfPresent([Int].self, forKey: .completedOrders) ?? [Int]()

        cards = try container.decodeIfPresent([Card].self, forKey: .cards) ?? [Card]()
        available = try container.decode(Bool.self, forKey: .available)
        livery = try container.decode(Livery.self, forKey: .livery)
        generation = try container.decode(Generation.self, forKey: .generation)
        rusting = try container.decode(Rusting.self, forKey: .rusting)
        orderCapacity = try container.decode(Int.self, forKey: .orderCapacity).clamp(low: 1, high: 5)
        references = try container.decode([Reference].self, forKey: .references)
        
        
        /**
        let generationValue = (generation.rawValue - 1)

        let meta = Meta.build()

        let metaGenerations: Int = {
            switch livery {
            case .green:
                return meta.cards.green.generations[generationValue]
            case .red:
                return meta.cards.red.generations[generationValue]
            case .yellow:
                return meta.cards.yellow.generations[generationValue]
            case .blue:
                return meta.cards.blue.generations[generationValue]
            }
        }()

        print ("\nMeta found: \(metaGenerations) results for \(livery) \(generation)")

        //let foundList = cards.filter { r in references.contains(where: { $0.id == r.id }) }
         **/

    }
}

extension Factory {
    static func == (lhs: Factory, rhs: Factory) -> Bool {
        return (lhs.id == rhs.id)
    }
}
