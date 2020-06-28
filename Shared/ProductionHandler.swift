//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 26/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Production Handler use cases

protocol ProductionUseCase {
    func increase(by amount: Int) throws -> Int
    func spend(amount: Int) throws -> Int
    func reset()
    func shift()
}

protocol FactoryProductionInjector: AnyObject {
    var fp : FactoryProductionUnitsDelegate { get }
    var trainDelegate: LocomotiveDelegate? { get }
    var playerDelegate: PlayerDelegate? { get }

    var costOfProduction: Int? { get }
    var isTrainAvailable: Bool { get }

    func spend(production: Int) -> Int
    func increase(production: Int) -> Int
    func reset()
}

class FactoryProductionInjected : FactoryProductionInjector {
    var fp: FactoryProductionUnitsDelegate
    var trainDelegate: LocomotiveDelegate?
    var playerDelegate: PlayerDelegate?

    var costOfProduction: Int? {
        guard let cost = self.trainDelegate?.productionCost else {
           return nil
       }
       return cost
    }

    var isTrainAvailable: Bool {
        guard let trainDelegate = self.trainDelegate else {
            return false
        }
        return trainDelegate.available
    }

    init(fp: FactoryProductionUnitsDelegate, train: LocomotiveDelegate? = nil, player: PlayerDelegate? = nil ) {
        self.fp = fp
        self.playerDelegate = player
        self.trainDelegate = train
    }

    internal func spend(production: Int) -> Int {
        self.fp.units -= production
        self.fp.spent += production
        return self.fp.units
    }

    internal func increase(production: Int) -> Int {
        self.fp.units += production
        return self.fp.units
    }

    internal func reset() {
        self.fp.units = self.fp.spent
        self.fp.spent = 0
    }
}

class ProductionHandler : ProductionUseCase {
    internal var fpi: FactoryProductionInjector!
    internal var spendingDelegate: Spender!
    internal var increaserDelegate: Increaser!

    init(with fpi: FactoryProductionInjector ) {
        self.fpi = fpi
        self.spendingDelegate = Spender(fpi.fp.units)
        self.increaserDelegate = Increaser(fpi.fp.units)
    }

    deinit {
        self.spendingDelegate = nil
        self.increaserDelegate = nil
    }

    // Increase production by amount
    func increase(by amount: Int) throws -> Int {
        do {

            if let playerDelegate = self.fpi.playerDelegate {
                // Do I have the cash to increase
                guard playerDelegate.cash > amount else {
                    throw SpendingError.notEnoughFunds(playerDelegate.cash)
                }
            }
            if let trainDelegate = self.fpi.trainDelegate {
                // Is the train available
                guard trainDelegate.available else {
                    throw TrainError.trainIsNotAvailable
                }
            }

            if try self.increaserDelegate.canIncrease(by: amount) {

                return self.fpi.increase(production: amount)
            }
            else {
                throw SpendingError.invalidAmount
            }
        }
        catch {
            throw error
        }
    }

    // Spend production units
    func spend(amount: Int) throws -> Int {
        do {
            if let _ = try self.spendingDelegate?.spend(amount: amount) {

                return self.fpi.spend(production: amount)
            }
            else {
                throw SpendingError.cannotSpend(amount)
            }
        }
        catch {
            throw error
        }
    }

    func reset() {
        self.fpi.reset()
    }

    func shift() {

    }
}

