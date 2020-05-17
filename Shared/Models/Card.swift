//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// : Card model as a struct
struct Card: Identifiable, FamilyProtocol {
    let id: UUID = UUID()
    var color: Family.Color
    var generation: Family.Generation
    let cost: Int
    var isAvailable: Bool = false
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
