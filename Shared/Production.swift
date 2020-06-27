//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 26/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol ProductionInputDelegate {
    var productionCost: Int { get }
    var production: Int { get set }
    var spentProduction: Int { get set }
}

protocol ProductionUseCase {
//    func reset()
//    func shift(units: Int, to card: Card, spending cash: Int) throws
}

class Production: ProductionUseCase {

    private var delegate: ProductionInputDelegate
    private var spendingDelegate: Spender?
    private var increaserDelegate: Increaser?

    var productionCost: Int {
        return delegate.productionCost
    }

    init(with delegate: ProductionInputDelegate) {
        self.delegate = delegate
        self.increaserDelegate = Increaser(productionCost)
        self.spendingDelegate = Spender(productionCost)
    }

    func increase(by units: Int, cash: Int = 0) throws -> ProductionInputDelegate {
        do {
            let canAfford = try self.canAfford(units: units, cash: cash)
            let canIncrease = try increaserDelegate?.canIncrease(by: units) ?? false

            if (canAfford && canIncrease) {
                if let increased = try increaserDelegate?.increase(by: units) {
                    self.delegate.production += increased
                    return self.delegate
                }
                else {
                    throw NSError(domain: "Could not call increaser.increase on \(units)", code: 0, userInfo: nil)
                }
            }
            else {
                throw NSError(domain: "Cannot increase production", code: 0, userInfo: ["canAfford": canAfford, "canIncrease": canIncrease])
            }
        }
        catch {
            throw error
        }
    }

    // Spend amount
    func spend(amount: Int) throws -> Int {
        do {
            if let result = try self.spendingDelegate?.spend(amount: amount) {
                self.delegate.production -= result
                self.delegate.spentProduction += result
                return result
            }
            else {
                throw SpendingError.cannotSpend(amount)
            }
        } catch {
            throw error
        }
    }

    // Reset production
    func reset() {
        didReset()
    }

    // Shift production from 1 card to another
    func shift() {
    }

    // MARK: - (PRIVATE) functions

    internal func didSpend(units: Int) {
        self.delegate.production -= units
        self.delegate.spentProduction += units
    }

    internal func didIncrease(units: Int) {
        self.delegate.production += 1
    }

    internal func didReset() {
        self.delegate.production = self.delegate.spentProduction
        self.delegate.spentProduction = 0
    }
}

extension Production {
    func canAfford(units: Int = 0, cash: Int = 0) throws -> Bool {
        guard units.isPositive else {
            throw SpendingError.mustBePositive(units)
        }
        guard cash.isPositive else {
            throw SpendingError.mustBePositive(cash)
        }

        let total = (units * productionCost)

        guard cash >= total else {
            throw SpendingError.cannotSpend(total)
        }

        return true
    }
}
