//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// : Card model as a struct
struct Card: Identifiable, CardFamilyProtocol {
    let id: UUID = UUID()
    var color: FamilyColor
    var generation: FamilyGeneration
    let cost: Int
    var isAvailable: Bool = false
    var name: String {
        return "\(self.color).\(self.generation)"
    }

    init(cost: Int, color: FamilyColor, generation: FamilyGeneration) {
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
