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
    //func increase()
    //func spend()
    func reset()
    func shift()
}

protocol FactoryProductionUnitsDelegate: AnyObject {
    var units: Int { get set }
    var spent: Int { get set }
}

class ProductionHandler : ProductionUseCase {
    internal var fp: FactoryProductionUnitsDelegate!
    internal var spendingDelegate: Spender!
    internal var increaserDelegate: Increaser!

    init(with fp: FactoryProductionUnitsDelegate) {
        self.fp = fp
        self.spendingDelegate = Spender(fp.units)
        self.increaserDelegate = Increaser(fp.units)
    }

    deinit {
        self.fp = nil
        self.spendingDelegate = nil
        self.increaserDelegate = nil
    }

    // Increase production by amount
    func increase(by amount: Int) throws -> Int {
        do {
            if try self.increaserDelegate.canIncrease(by: amount) {
                self.fp.increase(by: amount)
                return self.fp.units
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
                self.fp.spend(amount: amount)
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
        self.fp.reset()
    }

    func shift() {

    }
}


internal extension FactoryProductionUnitsDelegate {

    func increase(by amount: Int) {
        precondition(amount.isPositive, "To increase production, amount must be positive")
        self.units += amount
    }

    func spend(amount: Int) {
        precondition(amount.isPositive, "To spend production, amount must be positive")
        precondition( ((units - amount) >= 0)  , "Not enough funds -- Result from spend would be negative")
        self.units -= amount
        self.spent += amount
    }

    func reset() {
        self.units = self.spent
        self.spent = 0
    }

}

