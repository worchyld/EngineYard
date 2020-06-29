//
//  ProductionShiftHandler.swift
//  EngineYard
//
//  Created by Amarjit on 29/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol ShiftProductionUseCase: AnyObject {
    func shift(production units: Int, from origin: FactoryProduction, to destination: FactoryProduction) throws -> FactoryProduction?
}

class ShiftProductionHandler: ShiftProductionUseCase {

    /// Shift production from 1 card to another
    func shift(production units: Int, from origin: FactoryProduction, to destination: FactoryProduction) throws -> FactoryProduction? {

        return origin
    }

}


extension ShiftProductionHandler {

    func costToShift(production units: Int, from origin: FactoryProduction, to destination: FactoryProduction) throws -> Int {
        do {
            if try canShift(production: units, from: origin, to: destination) {
                // do something

            }
            return 0
        }
        catch {
            throw error
        }
    }

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

