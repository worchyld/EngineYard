//
//  ProductionManager.swift
//  EngineYard
//
//  Created by Amarjit on 09/10/2022.
//

import Foundation

public enum ProductionError: Error, Equatable {
    case notEnough(units: Int)
    case mustBePositive
    case haveNotSpentAnyUnits
}

private protocol PMUseCases {
    func add(units: Int, p: Production) -> Result<Production, ProductionError>
    func spend(units: Int, on p: Production) -> Result<Production, ProductionError>
    func reset(p: Production) -> Result<Production, ProductionError>
}

public class ProductionManager: PMUseCases {
    
    // add production
    func add(units: Int, p: Production) -> Result<Production, ProductionError> {
        do {
            try ProductionManager.validate(.add(units: units), p: p)
            let p = p.execute(.addProductionUnits(units))

            return .success(p)
        }
        catch let err {
            return .failure(err as! ProductionError)
        }
    }
    
    // spend production
    func spend(units: Int, on p: Production) -> Result<Production, ProductionError> {
        do {
            try ProductionManager.validate(.spend(units: units), p: p)
            let p = p.execute(.spendProductionUnits(units))

            return .success(p)
        }
        catch let err {
            return .failure(err as! ProductionError)
        }
    }
    
    // reset production
    func reset(p: Production) -> Result<Production, ProductionError> {
        do {
            try ProductionManager.validate(.reset, p: p)
            let p = p.execute(.resetProductionUnits)
            
            return .success(p)
        }
        catch let err {
            return .failure(err as! ProductionError)
        }
    }
}




extension ProductionManager {
    private enum ProductionAction {
        case add(units: Int)
        case spend(units: Int)
        case reset
        // todo: shift
    }
    
    private static func validate(_ useCase: ProductionAction, p: Production) throws {
        switch (useCase) {
        case .add(let units):
            guard units > 0 else {
                throw ProductionError.mustBePositive
            }
            
        case .spend(let spend):
            guard spend > 0 else {
                throw ProductionError.mustBePositive
            }
            guard p.units >= spend else {
                throw ProductionError.notEnough(units: p.units)
            }
            let sum = p.units - spend
            guard sum >= 0 else {
                throw ProductionError.notEnough(units: p.units)
            }
            
        case .reset:
            guard p.spent > 0 else {
                throw ProductionError.haveNotSpentAnyUnits
            }
        }
    }
}

