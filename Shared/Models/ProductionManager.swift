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

class ProductionManager {
    enum ProductionUseCase {
        case add(Int)
        case spend(Int)
        case reset
        // todo: shift
    }
    
    static func modify(production: Production, _ useCase: ProductionUseCase) -> Result<Production, ProductionError> {
        do {
            let _ = try ProductionManager.validate(useCase, p: production)

            switch (useCase) {
            case .add(let units):
                var p = production
                p = p.execute(.addProductionUnits(units))
                return .success(p)
                
            case .spend(let spend):
                var p = production
                p = p.execute(.spendProductionUnits(spend))
                return .success(p)
                
            case .reset:
                var p = production
                p = p.execute(.resetProductionUnits)
                return .success(p)
            }
            
        }
        catch let err {
            return .failure(err as! ProductionError)
        }
    }
}

extension ProductionManager {
    static func validate(_ useCase: ProductionUseCase, p: Production) throws {
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
