//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 09/10/2022.
//

import Foundation

// Production inventory
struct Production {
    let units: Int
    let spent: Int
    
    init(units: Int = 0, spent: Int = 0) {
        self.units = units
        self.spent = spent
    }
    
    enum Change {
        case setProductionUnits(Int,Int)
        case addProductionUnits(Int)
        case spendProductionUnits(Int)
        case resetProductionUnits
    }
    
    func execute(_ change: Change) -> Self {
        switch change {
        case .setProductionUnits(let units, let spent):
            return .init(units: units, spent: spent)
        case .addProductionUnits(let addUnits):
            let newUnits = self.units + addUnits
            return .init(units: newUnits, spent: spent)
        case .spendProductionUnits(let spentUnits):
            let newUnits = self.units - spentUnits
            let newSpend = self.spent + spentUnits
            return .init(units: newUnits, spent: newSpend)
        case .resetProductionUnits:
            let newUnits = self.units + self.spent
            return .init(units: newUnits, spent: 0)
        }
    }
}
