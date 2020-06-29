//
//  ProductionHandler.swift
//  EngineYard
//
//  Created by Amarjit on 28/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class ProductionHandler {

    /// Reset production to value set in spent; so long as you own the card resetting
    func reset(production: FactoryProduction, owner: Player) throws -> FactoryProduction {
        do {
            if try self.canReset(production: production, owner: owner) {
                production.units = production.spent
                production.spent = 0
                return production
            }
        }
        catch {
            throw error
        }
        return production
    }

    func increase() {
    }

    func spend() {
    }





    // MARK: - Shift Production methods

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

    /// Shift production from 1 card to another
    func shift(production units: Int, from origin: FactoryProduction, to destination: FactoryProduction) throws -> FactoryProduction {
        do {
            if try canShift(production: units, from: origin, to: destination) {
                // do something
            }
            return origin
        }
        catch {
            throw error
        }
    }
}

extension ProductionHandler {
    func canReset(production: FactoryProduction, owner: Player) throws -> Bool {
        guard owner.cards.count > 0 else {
            throw CardError(reason: .noCardsFound)
        }
        guard let _ = (owner.cards.first { (fp) -> Bool in
            return (fp == production)
        }) else {
            throw CardError(reason: .missingCard)
        }
        return true
    }
}

extension ProductionHandler {
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
