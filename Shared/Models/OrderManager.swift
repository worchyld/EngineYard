//
//  OrderManager.swift
//  EngineYard
//
//  Created by Amarjit on 16/04/2023.
//

import Foundation

enum OrderManagerError : Error {
    case locoIsNotBuilt
    case locoHasNoInitialOrder
    case locoAlreadyHasInitialOrder
    case locoLocoIsRusted
    case locoDicePoolIsFull
}

class OrderManager {
    private let loco: Locomotive
    
    init(loco: Locomotive) {
        self.loco = loco
    }
        
    func setInitialOrder() throws {
        guard (self.loco.rust == .notBuilt) else {
            throw OrderManagerError.locoIsNotBuilt
        }
        guard (self.loco.isDicePoolEmpty) else {
            throw OrderManagerError.locoDicePoolIsFull
        }
        guard (self.loco.initialOrder == nil) else {
            throw OrderManagerError.locoAlreadyHasInitialOrder
        }
        
        self.loco.initialOrder = D6.roll
        self.loco.rust.rustify()
    }
    
    func canAddExistingOrder(value: Int) throws -> Bool {
        guard (self.loco.rust == .notBuilt) else {
            throw OrderManagerError.locoIsNotBuilt
        }
        guard (self.loco.isDicePoolEmpty) else {
            throw OrderManagerError.locoDicePoolIsFull
        }
        
        return true
    }
    
    func canAddCustomerBase(value: Int) throws -> Bool {
        guard (self.loco.rust == .notBuilt) else {
            throw OrderManagerError.locoIsNotBuilt
        }
        guard (self.loco.isDicePoolEmpty) else {
            throw OrderManagerError.locoDicePoolIsFull
        }
        
        return true
    }
    
}
