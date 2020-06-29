//
//  ProductionHandler.swift
//  EngineYard
//
//  Created by Amarjit on 28/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class ProductionHandler {

    private var shiftProductionHandler: ShiftProductionUseCase?

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


    // MARK: Shift production

    /// Shift production from 1 card to another
    func shift(production units: Int, from origin: FactoryProduction, to destination: FactoryProduction) throws -> FactoryProduction? {

        self.shiftProductionHandler = ShiftProductionHandler()

        do {
            guard let delegate = shiftProductionHandler else {
                throw ProductionError(reason: .missingHandler)
            }
            if let result = try delegate.shift(production: units, from: origin, to: destination) {
                // do something

                return result
            }
            return nil
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
