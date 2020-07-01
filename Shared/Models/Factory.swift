//
//  Factory.swift
//  EngineYard
//
//  Created by Amarjit on 01/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class Factory : Codable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let avatar: String
    let livery: Livery
    let generation: Generation
    var cost: Int
    var rust: Rust
    var cards: [Card]?
    var maxDice: Int
    var trainPool: Int

    // orders
    var initialOrder: Int?
    var existingOrders: [Int]?
    var completedOrders: [Int]?

    // summarize all orders into 1 flattened array
    lazy var summarizedOrders: [Int] = {
        var orders: [Int] = [Int]()
        if let initial = self.initialOrder {
            orders.append( initial )
        }
        if let existing = self.existingOrders {
            let flattenExisting = existing.compactMap({ $0 })
            orders.append(contentsOf: flattenExisting)
        }
        if let completed = self.completedOrders {
            let flattenCompleted = completed.compactMap({ $0 })
            orders.append(contentsOf: flattenCompleted)
        }
        return orders
    }()

    // codingkeys
    private enum CodingKeys: String, CodingKey {
        case id, name, avatar, cost, livery, generation
        case rust, maxDice, trainPool, cards
        case initialOrder, existingOrders, completedOrders
    }

    init( id: UUID, name: String, avatar: String, livery: Livery, generation: Generation, cost: Int, rust: Rust, cards: [Card]?,  maxDice: Int, trainPool: Int, initialOrder: Int? = nil, existingOrders: [Int]? = nil, completedOrders: [Int]? = nil ) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.livery = livery
        self.generation = generation
        self.cost = cost
        self.rust = rust
        self.cards = cards
        self.maxDice = maxDice
        self.trainPool = trainPool
        self.initialOrder = initialOrder
        self.existingOrders = existingOrders
        self.completedOrders = completedOrders
    }

    required init(from decoder: Decoder) throws {
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

        maxDice = try container.decode(Int.self, forKey: .maxDice).clamp(low: 1, high: 6)
        trainPool = try container.decode(Int.self, forKey: .trainPool).clamp(low: 1, high: 4)

        livery = try container.decode(Livery.self, forKey: .livery)
        generation = try container.decode(Generation.self, forKey: .generation)
        rust = try container.decodeIfPresent(Rust.self, forKey: .rust) ?? Rust.new

        initialOrder = try container.decodeIfPresent(Int.self, forKey: .initialOrder) ?? nil
        existingOrders = try container.decodeIfPresent([Int].self, forKey: .existingOrders) ?? nil //[Int]()
        completedOrders = try container.decodeIfPresent([Int].self, forKey: .completedOrders) ?? nil // [Int]()

        cards = try container.decodeIfPresent([Card].self, forKey: .cards) ?? [Card]()
    }
}

// Comparisons
extension Factory {
    static func == (lhs: Factory, rhs: Factory) -> Bool {
        return (lhs.id == rhs.id)
    }

    static func > (lhs: Factory, rhs: Factory) -> Bool {
        return (lhs.generation.rawValue > rhs.generation.rawValue)
    }
}

// production and income lookup
extension Factory {
    var productionCost: Int {
        guard (self.cost % 4 == 0) else { return 0 }
        return Int( floor(Double(self.cost / 2)) )
    }

    var income: Int {
        guard (cost % 4 == 0) else { return 0 }
        return Int( floor(Double(productionCost / 2)) )
    }

    var isAvailable: Bool {
        return ((self.summarizedOrders.count > 0) && (self.rust != .rusted))
    }
}
