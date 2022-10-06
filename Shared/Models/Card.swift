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
  
//    // Lookup vars
//    var name: String {
//        return loco.name
//    }
//    var cost: Int {
//        return loco.cost
//    }
//    var productionCost: Int {
//        return loco.productionCost
//    }
//    var income: Int {
//        return loco.income
//    }
//    var livery: Livery {
//        return loco.livery
//    }
//    var generation: Generation {
//        return loco.generation
//    }
//    var rust: Rust {
//        return loco.rust
//    }
    
    // Production units
    var units: Int = 0
    var spentUnits: Int = 0
    
    init(loco: Locomotive) {
        self.loco = loco
    }
}
