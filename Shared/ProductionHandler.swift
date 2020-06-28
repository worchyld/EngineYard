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
    var fp : FactoryProduction { get }
}

class FactoryProductionInjected : FactoryProductionInjector {
    var fp: FactoryProduction

    init(fp: FactoryProduction) {
        self.fp = fp
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
            if try self.increaserDelegate.canIncrease(by: amount) {
                //self.fp.increase(by: amount)
                //return self.fp.units

                self.fpi.fp.units += amount
                return self.fpi.fp.units
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
            if let result = try self.spendingDelegate?.spend(amount: amount) {
                //self.fp.spend(amount: amount)
                //return result

                self.fpi.fp.units -= amount
                self.fpi.fp.spent += amount

                return result
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
        //self.fp.reset()
        self.fpi.fp.units = self.fpi.fp.spent
        self.fpi.fp.spent = 0
    }

    func shift() {

    }
}

