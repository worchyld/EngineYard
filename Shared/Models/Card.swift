//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import Foundation

typealias Card = LocomotiveCard

class LocomotiveCard {
    private let uuid: UUID = UUID()
    private let _loco: Locomotive
    public var loco: Locomotive {
        return self._loco
    }
  
    // Production inventory
    struct Production {
        let units: Int
        let spent: Int
        
        init(units: Int = 0, spent: Int = 0) {
            self.units = units
            self.spent = spent
        }
    }
    internal var production: Production
    
    init(loco: Locomotive) {
        self._loco = loco
        self.production = Production()
    }
}
