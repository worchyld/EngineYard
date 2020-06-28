//
//  Factory.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum TrainError : Error, Equatable {
    case trainDoesNotExist(train: Train)
    case trainIsNotAvailable(train: Train)
    case trainHasRusted(train: Train)
    case trainCannotBePurchased(train: Train)
    case trainHasNoExistingOrders(train: Train)
    case trainHasNoCompletedOrders(train: Train)
    case trainHasNoInitialOrder(train: Train)
    case cannotShiftProductionFrom(origin: Train, destination: Train)
    case alreadyHaveThisTrain(_ train: Train)
}

protocol LocomotiveDelegate {
    var id: UUID { get }
    var name: String { get }
    var cost: Int { get }
    var income: Int { get }
    var livery : Livery { get }
    var generation : Generation { get }
    var rusting : Rusting { get }
    var available : Bool { get }
}

// MARK: - Train
struct Train: Codable, Identifiable, Equatable, LocomotiveDelegate {
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
