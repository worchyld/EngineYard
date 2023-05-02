//
//  CardViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 02/05/2023.
//

import Foundation

struct CardViewModel: Identifiable, Equatable {
    
    internal let id: UUID
    let loco: Locomotive
    let productionUnits: Int
    let spentUnits: Int
    
    init(id: UUID, loco: Locomotive, productionUnits: Int, spentUnits: Int) {
        self.id = id
        self.loco = loco
        self.productionUnits = productionUnits
        self.spentUnits = spentUnits
    }
    
    static func == (lhs: CardViewModel, rhs: CardViewModel) -> Bool {
        return (lhs.id == rhs.id)
    }
    
}
