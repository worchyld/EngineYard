//
//  FactoryProduction.swift
//  EngineYard
//
//  Created by Amarjit on 27/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias Card = FactoryProduction

class FactoryProduction : Identifiable, Codable {
    private(set) weak var parent: Train?
    private(set) weak var owner: Player?
    let id: UUID
    var units: Int
    var spent: Int
    var deleted: Bool

    init(id: UUID, units: Int = 0, _ spent: Int = 0) {
        self.id = id
        self.units = units
        self.spent = spent
        self.deleted = false
    }

    private enum CodingKeys: String, CodingKey {
        case id, units, spent, deleted
    }
}

extension FactoryProduction : Equatable {
    static func == (lhs: FactoryProduction, rhs: FactoryProduction) -> Bool {
        return (lhs.id == rhs.id)
    }
}

extension FactoryProduction : CustomStringConvertible {
    var description: String {
        return ("units: \(self.units), spent: \(spent), deleted: \(deleted)")
    }
}

// Builder pattern

protocol FactoryProductionBuilder: AnyObject {
    static func build( _ owner: Player?, _ train: Train?, units: Int ) -> FactoryProduction
}

extension FactoryProduction : FactoryProductionBuilder {
    public static func build( _ owner: Player? = nil, _ train: Train? = nil, units: Int = 1 ) -> FactoryProduction {

        let fp = FactoryProduction.init( id: UUID(), units: units)
        fp.parent = train
        fp.owner = owner

        return fp
    }
}
