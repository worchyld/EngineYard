//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 16/04/2023.
//

import Foundation

struct Card {
    let locomotive: Int?
    var productionUnits: Int = 1
    var spentUnits: Int = 0
    
    init(locomotive: Int?, productionUnits: Int, spentUnits: Int = 0) {
        self.locomotive = locomotive
        self.productionUnits = productionUnits
        self.spentUnits = spentUnits
    }
}

extension Card {
    mutating func add(units: Int) throws {
        self.productionUnits += units
    }
    mutating func spend(units: Int) throws {
        self.spentUnits += units
        self.productionUnits -= units
    }
    
    mutating func reset() {
        self.productionUnits = self.spentUnits
        self.spentUnits = 0
    }

}
