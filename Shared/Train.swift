//
//  Factory.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol TrainDelegate {
    var id: UUID { get }
    var name: String { get }
    var cost: Int { get }
    var productionCost: Int { get }
    var income: Int { get }
    var livery : Livery { get }
    var generation : Generation { get }
    var rusting : Rusting { get }
    var available : Bool { get }
    var initialOrder: Int? { get }
    var existingOrders: [Int]? { get }
    var completedOrders: [Int]? { get }
    var factoryProduction: [FactoryProduction]? { get }
    func hasOrders() -> Bool
}

// MARK: - Train
class Train: Codable, Identifiable, Equatable, TrainDelegate {
    let id : UUID
    let name, avatar: String
    let cost, trainPool: Int
    let livery : Livery
    let generation : Generation
    var available: Bool
    var rusting : Rusting
    let maxDice: Int

    var initialOrder: Int?
    var existingOrders: [Int]?
    var completedOrders: [Int]?

    var factoryProduction: [FactoryProduction]?

    private enum CodingKeys: String, CodingKey {
        case id, name, avatar, cost, livery, generation
        case trainPool = "train-pool"
        case available, rusting, maxDice
        case initialOrder, existingOrders, completedOrders
        case factoryProduction
    }

    init(id: UUID, name: String, avatar: String, cost: Int, trainPool: Int, livery: Livery, generation: Generation, available: Bool, rusting: Rusting, maxDice: Int, initialOrder: Int?, existingOrders: [Int]?, completedOrders: [Int]?, factoryProduction: [FactoryProduction]?) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.cost = cost
        self.trainPool = trainPool
        self.livery = livery
        self.generation = generation
        self.available = available
        self.rusting = rusting
        self.maxDice = maxDice
        self.initialOrder = initialOrder
        self.existingOrders = existingOrders
        self.completedOrders = completedOrders
        self.factoryProduction = factoryProduction
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
        available = try container.decodeIfPresent(Bool.self, forKey: .available) ?? false

        livery = try container.decode(Livery.self, forKey: .livery)
        generation = try container.decode(Generation.self, forKey: .generation)
        rusting = try container.decode(Rusting.self, forKey: .rusting)

        initialOrder = try container.decodeIfPresent(Int.self, forKey: .initialOrder)
        existingOrders = try container.decodeIfPresent([Int].self, forKey: .existingOrders) ?? [Int]()
        completedOrders = try container.decodeIfPresent([Int].self, forKey: .completedOrders) ?? [Int]()

        factoryProduction = try container.decodeIfPresent([FactoryProduction].self, forKey: .factoryProduction) ?? [FactoryProduction]()
    }
}

extension Train {
    var productionCost: Int {
        guard (self.cost % 4 == 0) else { return 0 }
        return Int( floor(Double(self.cost / 2)) )
    }

    var income: Int {
        guard (cost % 4 == 0) else { return 0 }
        return Int( floor(Double(productionCost / 2)) )
    }
}

extension Train {
    func hasOrders() -> Bool {
        var flag = false
        if let initialOrder = self.initialOrder {
            if initialOrder > 0 {
                flag = true
            }
        }
        if let existingOrders = self.existingOrders {
            flag = (existingOrders.reduce(0, +) > 0)
        }
        if let completedOrders = self.completedOrders {
            flag = (completedOrders.reduce(0, +) > 0)
        }
        return flag
    }
}


extension Train {
    static func == (lhs: Train, rhs: Train) -> Bool {
        return (lhs.id == rhs.id)
    }
    static func != (lhs: Train, rhs: Train) -> Bool {
        return (lhs.id != rhs.id)
    }
    static func isOlder(lhs: Train, rhs: Train) -> Bool {
        return (lhs.generation.rawValue > rhs.generation.rawValue)
    }
}


extension Train {

}
