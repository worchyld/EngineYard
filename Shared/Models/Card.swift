//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import Foundation

class Card {
    private let uuid: UUID = UUID()
    let name: String
    let image: String
    let cost: Int
    public var productionCost: Int {
        return cost / 2
    }
    public var income: Int {
        return self.productionCost / 2
    }
    
    let livery: Livery
    let generation: Generation
    var productionUnits: Int
    var rust: Rust = .notBuilt 
        
    init(_ cost: Int, _ livery: Livery, _ generation: Generation) {
        self.cost = cost
        self.livery = livery
        self.image = livery.iconAsset
        self.generation = generation
        self.name = livery.description.lowercased() + "." + generation.description.lowercased()
        self.productionUnits = 0
    }
}

extension Card : CustomStringConvertible {
    var description: String {
        return (self.name)
    }
}

extension Card : Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return (lhs.uuid == rhs.uuid)
    }
}
