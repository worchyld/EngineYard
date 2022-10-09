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
  
    internal var production: Production?
    
    init(loco: Locomotive) {
        self._loco = loco
        self.production = Production(units: 0, spent: 0)
    }
}
