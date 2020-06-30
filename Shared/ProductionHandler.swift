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

    init() {
        self.shiftProductionHandler = ShiftProductionHandler()
    }


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


    /// Spend production units
    /// Must be positive, must have enough units to spend
    /// Must be owned by the player
    func spend(production: FactoryProduction, units: Int, owner: Player) throws -> FactoryProduction {
        do {
            if try validate(production: production, owner: owner) {

                let balance = try spend(production: production.units, spend: units)
                guard (balance >= 0) else {
                    throw ProductionError(reason: .notEnoughProduction)
                }

                production.units -= units
                production.spent += units
                return production
            }
            else {
                throw ProductionError(reason: .notEnoughProduction)
            }
        }
        catch {
            throw error
        }
    }


    /// Validation on production
    /// (a) Player must own the factoryproduction object being modified
    /// (b) Parent factory cannot be rusted
    /// (c) Parent factory must be active
    internal func validate(production: FactoryProduction, owner: Player) throws -> Bool {

        guard let hasOwner = production.owner else {
            throw ProductionError(reason: .missingOwner)
        }
        guard let train = production.parent else {
            throw ProductionError(reason: .missingParent)
        }
        guard (hasOwner == owner) else {
            throw ProductionError(reason: .notYours)
        }
        guard (train.rust != .rusted) else {
            throw TrainError(reason: .rusted)
        }
        guard (train.available) else {
            throw TrainError(reason: .unavailable)
        }
        return true
    }


    // MARK: Shift production

    /// Shift production from 1 card to another
    func shift(production units: Int, from origin: FactoryProduction, to destination: FactoryProduction) throws -> FactoryProduction? {


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


extension ProductionHandler {
    internal func spend(production units: Int, spend amount: Int) throws -> Int {
        let spender = Spender(units)
        do {
            return try spender.spend(amount: amount)
        }
        catch {
            throw error
        }
    }
}
