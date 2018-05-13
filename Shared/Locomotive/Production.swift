//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class Production : NSObject {
    public private (set) weak var parent: Card?
    public private (set) var units: Int = 0
    public private (set) var spentUnits: Int = 0

    func setInitialProduction() {
        self.units = 1
        self.spentUnits = 0
    }

    func add(amount: Int = 0) {
        self.units += amount
    }

    func spend(amount: Int = 0) {
        self.spentUnits += amount
        self.units -= amount
    }

    func reset() {
        self.units = spentUnits
        self.spentUnits = 0
    }

}
