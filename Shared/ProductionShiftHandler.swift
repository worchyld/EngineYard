//
//  ProductionShiftHandler.swift
//  EngineYard
//
//  Created by Amarjit on 29/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol ShiftProductionUseCase {
    func shift()
}

class ShiftProductionHandler {

    var factoryProduction: FactoryProduction?

    

}


extension ShiftProductionHandler {
    /// + Must own both the origin and destination card
    /// + origin card cannot be destination card
    /// + destination card must be older than the origin card
    /// + destination must be available (hasOrders == true) && (not rusting)
    /// + must be able to afford the shift
    func canShift(production units: Int, from origin: FactoryProduction, to destination: FactoryProduction) throws -> Bool {
        return true
    }

    /// Rules state that if post-shifting; if units on origin card are nil; remove card from game
    func willShiftingProductionLoseCard(_ units: Int, origin: FactoryProduction) -> Bool {
        return true
    }

    /// Check if origin card was left empty; if it is; remove the card from game (mark it as deleted)
    func postShift(origin: FactoryProduction) {

    }
}

