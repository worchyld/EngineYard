//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias Card = Locomotive

// : Locomotive model as a struct
struct Locomotive: Identifiable, FamilyProtocol {
    let id: UUID = UUID()
    var color: Family.Color
    var generation: Family.Generation
    let cost: Int
    var productionCost: Int {
        guard (self.cost % 4 == 0) else { return 0 }
        return Int( floor(Double(self.cost / 2)) )
    }
    var income: Int {
        guard (cost % 4 == 0) else { return 0 }
         return Int( floor(Double(productionCost / 2)) )
    }
    var name: String {
        return "\(self.color).\(self.generation)"
    }

    init(cost: Int, color: Family.Color, generation: Family.Generation) {
        self.cost = cost
        self.color = color
        self.generation = generation
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
