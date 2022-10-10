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


public class ProductionManager {
    private var _production: Production
    
    init(production: Production) {
        self._production = production
    }

    public enum ProductionAction {
        case add(units: Int)
        case spend(units: Int)
        case reset
        // todo: shift
    }
    
    
    func perform(action: ProductionAction) -> Result<Production, ProductionError> {        
        do {
            let _ = try ProductionManager.validate(action, p: self._production)
            
            switch (action) {
            case .add(let units):
                self._production = _production.execute(.addProductionUnits(units))
                return .success(self._production)
                
            case .spend(let units):
                self._production = _production.execute(.spendProductionUnits(units))
                return .success(self._production)
                
            case .reset:
                self._production = self._production.execute(.resetProductionUnits)
                return .success(self._production)
            }
            
        }
        catch let err {
            return .failure(err as! ProductionError)
        }
    }
}


extension ProductionManager {
    static func validate(_ useCase: ProductionAction, p: Production) throws {
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
