//
//  ProductionManager.swift
//  EngineYard
//
//  Created by Amarjit on 17/04/2023.
//

import Foundation

class ProductionManager {
    private var card: Card
    
    init(card: Card) {
        self.card = card
    }
    
    func add(units: Int) {
        self.card.productionUnits += units
    }
    
    func spend(units: Int) {
        let sum = self.card.productionUnits - units
        guard sum >= 0 else {
            return
        }
        self.card.spentUnits += units
        self.card.productionUnits = sum
    }
    
    func reset() {
        self.card.productionUnits = self.card.spentUnits
        self.card.spentUnits = 0
    }
}
