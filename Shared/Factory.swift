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
    let cards: [Card]?
    let available: Bool
    let rusting: Rusting
    let orderCapacity: Int
}

// MARK: - Card
struct Card: Codable {
    let id: UUID
    let name, avatar: String
    let cost: Int
    let generation: Generation
    let livery: Livery
}

protocol ProductionAndIncome {
    var productionCost: Int { get }
    var income: Int { get }
}

extension Factory : ProductionAndIncome {
    var productionCost: Int {
        guard (self.cost % 4 == 0) else { return 0 }
        return Int( floor(Double(self.cost / 2)) )
    }
    var income: Int {
        guard (cost % 4 == 0) else { return 0 }
        return Int( floor(Double(productionCost / 2)) )
    }
}



extension Factory {
    static func == (lhs: Factory, rhs: Factory) -> Bool {
        return (lhs.id == rhs.id)
    }
}

