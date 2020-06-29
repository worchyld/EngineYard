//
//  FactoryProduction.swift
//  EngineYard
//
//  Created by Amarjit on 27/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class FactoryProduction : Identifiable, Codable {
    let id: UUID
    var units: Int
    var spent: Int
    //private weak var train: Train?
    //private weak var owner: Player?

    init(train: Train? = nil, owner: Player? = nil, id: UUID, units: Int = 0, _ spent: Int = 0) {
        //self.train = train
        //self.owner = owner
        self.id = id
        self.units = units
        self.spent = spent
    }

    private enum CodingKeys: String, CodingKey {
        case id, units, spent
    }
}

extension FactoryProduction : Equatable {
    static func == (lhs: FactoryProduction, rhs: FactoryProduction) -> Bool {
        return (lhs.id == rhs.id)
    }
}

extension FactoryProduction : CustomStringConvertible {
    var description: String {
        return ("units: \(self.units), spent: \(spent)")
    }
}
