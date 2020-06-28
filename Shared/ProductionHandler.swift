//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 26/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

/**
    **Production Handler**

    Use cases:
    (1) Increase factory production
    (2) Spend factory production
    (3) Reset factory production
    (4) Shift factory production from 1 factory to another?

    **Increase factory production**
    Cannot be negative
    Must have the cash to increase it

    **Spend factory production**
    Cannot be negative
    Cannot spend more than you have

    **Reset factory production**
    Set units to spent
    Set spent to zero
*/

protocol ProductionUseCase {
    func increase(by amount: Int) throws -> Int
    func spend(amount: Int) throws -> Int
    func reset() throws
    func shift()
}

protocol FactoryProductionInjector: AnyObject {
    var fp : FactoryProductionUnitsDelegate? { get }
    var playerFactoryConnection: PlayerFactoryConnectionDelegate? { get }

    func spend(production: Int) throws -> Int
    func increase(production: Int) throws -> Int
    func reset() throws
}

protocol PlayerFactoryConnectionDelegate {
    var trainDelegate: LocomotiveDelegate? { get }
    var playerDelegate: PlayerDelegate? { get }
}

class PlayerFactoryConnection: PlayerFactoryConnectionDelegate {
    var trainDelegate: LocomotiveDelegate?
    var playerDelegate: PlayerDelegate?

    init(trainDelegate: LocomotiveDelegate?, playerDelegate: PlayerDelegate?) {
        self.trainDelegate = trainDelegate
        self.playerDelegate = playerDelegate
    }
}

class FactoryProductionInjected : FactoryProductionInjector {
    var fp: FactoryProductionUnitsDelegate?
    var playerFactoryConnection: PlayerFactoryConnectionDelegate?

    init(fp: FactoryProductionUnitsDelegate, playerFactoryConnection: PlayerFactoryConnectionDelegate? = nil) {
        self.fp = fp
        self.playerFactoryConnection = playerFactoryConnection
    }

    internal func spend(production: Int) throws -> Int {
        guard let fp = self.fp else {
            throw NSError(domain: "Factory production link does not exist", code: 0, userInfo: nil)
        }
        fp.units -= production
        fp.spent += production
        return fp.units
    }

    internal func increase(production: Int) throws -> Int {
        guard let fp = self.fp else {
            throw NSError(domain: "Factory production link does not exist", code: 0, userInfo: nil)
        }
        fp.units += production
        return fp.units
    }

    internal func reset() throws {
        guard let fp = self.fp else {
            throw NSError(domain: "Factory production link does not exist", code: 0, userInfo: nil)
        }
        fp.units = fp.spent
        fp.spent = 0
    }
}

class ProductionHandler : ProductionUseCase {
    internal var fpi: FactoryProductionInjector!
    internal var spendingDelegate: Spender!
    internal var increaserDelegate: Increaser!

    init(with fpi: FactoryProductionInjector ) {
        self.fpi = fpi
        guard let fp = self.fpi.fp else {
            return
        }
        self.spendingDelegate = Spender(fp.units)
        self.increaserDelegate = Increaser(fp.units)
    }

    deinit {
        self.spendingDelegate = nil
        self.increaserDelegate = nil
    }

    // Increase production by amount
    func increase(by amount: Int) throws -> Int {
        do {
            if try self.increaserDelegate.canIncrease(by: amount) {

                return try self.fpi.increase(production: amount)
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

                return try self.fpi.spend(production: amount)
            }
            else {
                throw SpendingError.cannotSpend(amount)
            }
        }
        catch {
            throw error
        }
    }

    func reset() throws {
        try self.fpi.reset()
    }

    func shift() {

    }
}

