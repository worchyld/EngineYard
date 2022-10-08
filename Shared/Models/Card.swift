//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import Foundation

class Card {
    private let uuid: UUID = UUID()
    let loco: Locomotive
  
    // Production units
    var productionUnits: Int = 0
    var spentUnits: Int = 0
    
    init(loco: Locomotive) {
        self.loco = loco
    }
}
