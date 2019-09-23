//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum ProductionError : Error {
    case mustBePositive
    case notEnoughUnits
    case cannotSelectSameCard
    case cannotSelectCardFromSameParent
    case cannotUpgradeDownstream
}

struct Card {
    let units: Int
    private let spentUnits: Int
}


extension Card {
    private func canSpend(amount: Int) throws {
        guard amount > 0 else {
            throw ProductionError.mustBePositive
        }
        guard self.units >= amount else {
            throw ProductionError.notEnoughUnits
        }
        guard (self.units - amount >= 0) else {
            throw ProductionError.notEnoughUnits
        }
    }
}
