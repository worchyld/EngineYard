//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 13/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum ProductionError : Error, Equatable {
    case notEnoughUnits(units: Int)
    case resultWillBeNegative(value: Int)
}

struct Production {
    private (set) var units: Int
    private (set) var spentUnits: Int

    init(_ units: Int = 0) {
        if (units >= 0) {
            self.units = units
        }
        else {
            self.units = 0
        }
        self.spentUnits = 0
    }
}

extension Production {
    mutating func reset() {
        self.units += spentUnits
        self.spentUnits = 0
    }

    mutating func add(_ units: Int) {
        guard units > 0 else {
            return
        }
        self.units += units
    }

    mutating func spend(_ units: Int) throws {
        do {
            let ok = try canSpend(units)
            if ok {
                print ("ok to spend")
                decreaseProduction(by: units)
            }
            else {
                throw ProductionError.notEnoughUnits(units: units)
            }
        } catch {
            throw error
        }
    }

    internal mutating func decreaseProduction(by units: Int) {
        self.spentUnits += units
        self.units -= units
    }

    internal func canSpend(_ units: Int) throws -> Bool {
        guard units > 0 else {
            throw ProductionError.notEnoughUnits(units: units)
        }
        guard self.units > 0 else {
            throw ProductionError.notEnoughUnits(units: units)
        }
        let sum = (self.units - units)
        guard sum > 0 else {
            throw ProductionError.resultWillBeNegative(value: units)
        }

        return true
    }
}
