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

class ProductionHandler : ProductionUseCase {
    var fp: FactoryProduction!
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
            guard let result = try self.spendingDelegate?.spend(amount: amount) else {
                throw SpendingError.cannotSpend(amount)
            }
            return result
        }
        catch {
            throw error
        }
    }

    func reset() {
    }

    func shift() {

    }
}
