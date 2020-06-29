//
//  ProductionHandler.swift
//  EngineYard
//
//  Created by Amarjit on 28/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class ProductionHandler {

    func reset(production: FactoryProduction) -> FactoryProduction {
        production.units = production.spent
        production.spent = 0
        return production
    }

    func increase(amount: Int, on subject: FactoryProduction, train: TrainDelegate, player: PlayerDelegate) throws -> FactoryProduction {

        return subject

    }

    func spend(amount: Int, on subject: FactoryProduction, train: TrainDelegate ) throws -> FactoryProduction {

        return subject
    }
}
