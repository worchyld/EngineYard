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

protocol ProductionInputDelegate: AnyObject {
    var units: Int { get }
    var spent: Int { get }
}

class ProductionHandler : ProductionUseCase {
    internal var fp: FactoryProduction!
    internal var spendingDelegate: Spender?
    internal var increaserDelegate: Increaser?    

    init(with fp: FactoryProduction) {
        self.fp = fp
        self.spendingDelegate = Spender(fp.units)
        self.increaserDelegate = Increaser(fp.units)
    }

    func increase() {

    }

    func spend(amount: Int) throws -> Int {
        do {
            if let result = try self.spendingDelegate?.spend(amount: amount) {
                fp.units = result
                fp.spent += amount
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
        self.fp.units = self.fp.spent
        self.fp.spent = 0
    }

    func shift() {

    }
}
