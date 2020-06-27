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
    func increase()
    //func spend()
    func reset()
    func shift()
}

protocol FactoryProductionInputDelegate: AnyObject {
    var units: Int { get set }
    var spent: Int { get set }
}

class ProductionHandler : ProductionUseCase {
    internal var fp: FactoryProductionInputDelegate!
    internal var spendingDelegate: Spender!
    internal var increaserDelegate: Increaser!

    init(with fp: FactoryProductionInputDelegate) {
        self.fp = fp
        self.spendingDelegate = Spender(fp.units)
        self.increaserDelegate = Increaser(fp.units)
    }

    deinit {
        self.fp = nil
        self.spendingDelegate = nil
        self.increaserDelegate = nil
    }

    func increase() {

    }

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


fileprivate extension FactoryProductionInputDelegate {

    func spend(amount: Int) {
        self.units -= amount
        self.spent += amount
    }

    func reset() {
        self.units = self.spent
        self.spent = 0
    }

}

