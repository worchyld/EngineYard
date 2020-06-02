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
    let cost: Int
    let family: Family

    init(cost: Int, color: Family.Color, generation: Family.Generation) {
        self.cost = cost
        self.family = Family.init(color: color, generation: generation)
    }
}

// MARK - Lookup variables
extension Card {
    var name: String {
        return "\(self.family.color).\(self.family.generation)"
    }

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
        return ("\(self.id), \(self.name), $\(self.cost), \(self.family as Any)")
    }
}
