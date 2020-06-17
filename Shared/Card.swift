//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct Card : Identifiable {
    let id: UUID = UUID()
    let name: String
    let cost: Int
    let family: Family
    private (set) var production: Production

    init(name: String, cost: Int, color: Family.Color, generation: Family.Generation) {
        self.name = name
        self.cost = cost
        self.family = Family(color: color, generation: generation)
        self.production = Production.init()
    }
}

// MARK - Extensions

extension Card : FamilyDelegate {
    var color: Family.Color { return self.family.color }
    var generation: Family.Generation { return self.family.generation }
}

extension Card {
    var productionCost: Int {
        guard (self.cost % 4 == 0) else { return 0 }
        return Int( floor(Double(self.cost / 2)) )
    }
    var income: Int {
        guard (cost % 4 == 0) else { return 0 }
        return Int( floor(Double(productionCost / 2)) )
    }
}

extension Card: Equatable {
    public static func ==(lhs: Card, rhs: Card) -> Bool {
        return (lhs.id == rhs.id)
    }
}

extension Card: CustomStringConvertible {
    var description: String {
        return ("\(self.id), \(self.name), $\(self.cost), \(self.color), \(self.generation)")
    }
}

extension Card {
    mutating func setProdction(_ production: Production) {
        self.production = production
    }
}
