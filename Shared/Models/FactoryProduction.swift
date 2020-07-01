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
    weak var parent: Train?
    weak var owner: Player?
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
