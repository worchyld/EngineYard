//
//  ProductionShifter.swift
//  EngineYard
//
//  Created by Amarjit on 26/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Only deals with shifting production units from 1 card to another

protocol ProductionShifterUseCase {
    func shift(production: Int, from: Card, to: Card) throws
}

class ProductionShifter : ProductionShifterUseCase {

    init() {}

    func shift(production: Int, from: Card, to: Card) throws {

    }
}


extension ProductionShifter {
    func canShift(production: Int, from: Card, to: Card) throws -> Bool {
        return true
    }

    func canAffordShifting(production: Int, from: Card, to: Card) -> Bool {
        return true
    }

    func costOfShifting(production: Int, from: Card, to: Card) -> Int {
        return 0
    }

}
