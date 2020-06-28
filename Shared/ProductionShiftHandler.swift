//
//  ProductionShiftHandler.swift
//  EngineYard
//
//  Created by Amarjit on 26/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol ProductionShiftUseCase {
    //func shift()
}

class ProductionShiftHandler : ProductionShiftUseCase {
    func shift(production: FactoryProduction ) {

    }
}

extension ProductionShiftHandler {
    func canShift() -> Bool {
        return true
    }

    /*
    func canShift(production: Int, from origin: Card, to destination: Card) throws -> Bool {
        guard production.isPositive else {
            throw SpendingError.mustBePositive(production)
        }
        guard (origin != destination) else {
            let message = "The origin card \(origin.name) is the same as the destination card \(destination.name)"
            let error = NSError(domain: message, code: 0, userInfo: ["origin.id": origin.id, "destination.id": destination.id ] )
            throw error
        }
        guard (origin.generation.rawValue == destination.generation.rawValue) else {
            let message = "The origin card \(origin.name) cannot be the same generation as the destination card \(destination.name)"
            let error = NSError(domain: message, code: 0, userInfo: ["origin.id": origin.id, "destination.id": destination.id, "origin.generation": origin.generation ] )
            throw error
        }
        guard (origin.generation.rawValue < destination.generation.rawValue) else {
            let message = "The origin card \(origin.name) must be younger than the destination card \(destination.name)"
            let error = NSError(domain: message, code: 0, userInfo: ["origin.id": origin.id, "destination.id": destination.id, "origin.generation": origin.generation, "destination.generation": destination.generation ] )
            throw error
        }
        // destination must be active (has orders)
        // destination cannot be rusted

        return true
    }
    */
}
