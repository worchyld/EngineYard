//
//  OrderManager.swift
//  EngineYard
//
//  Created by Amarjit on 16/04/2023.
//

import Foundation

enum OrderManagerError : Error {
    case noLoco
    case locoIsNotBuilt
    case locoHasNoInitialOrder
    case locoAlreadyHasInitialOrder
    case locoHasOrdersOrSales
    case locoLocoIsRusted
    case locoDicePoolIsFull
    case notAValidD6
    case cannotReassignInitialOrder
}

class OrderManager {
    private weak var loco: Locomotive?
    private var orders: [Int]
    private var sales: [Int]
    private var initialOrder: Int?

    init(loco: Locomotive) {
        self.loco = loco
        self.orders = loco.existingOrders
        self.sales = loco.customerBase
    }
    
    private func rollOrder() -> Int {
        return D6.roll
    }
    
    private func applyToLoco() {
        guard let hasLoco = self.loco else {
            return
        }
        hasLoco.initialOrder = self.initialOrder
        hasLoco.existingOrders = self.orders
        hasLoco.customerBase = self.sales
    }
    
    func transferAllToOrdersAndReroll() {
        for _ in sales {
            let value = rollOrder()
            orders.append(value)
        }
        sales.removeAll()
    }
    
    func setInitialOrder() {
        guard let _ = self.loco else {
            return
        }
        let value = rollOrder()
        self.initialOrder = value
        
        applyToLoco()
    }
    
    internal func addToExistingOrder() throws {
        guard let _ = self.loco else {
            throw OrderManagerError.noLoco
        }
        do {
            try self.validateAddOrder()
            
            let value = self.rollOrder()
            self.orders.append(value)
            
            applyToLoco()
        } catch let err {
            throw err
        }
    }
    
    internal func addToCustomerBase(value: Int) throws {
        guard let _ = self.loco else {
            throw OrderManagerError.noLoco
        }
        guard D6.isValid(value) else {
            throw OrderManagerError.notAValidD6
        }
        self.sales.append(value)
    }

    internal func validateAddOrder() throws {
        guard let hasLoco = self.loco else {
            throw OrderManagerError.noLoco
        }
        guard hasLoco.isDicePoolEmpty else {
            throw OrderManagerError.locoDicePoolIsFull
        }
        let qty = (hasLoco.customerBase.count + hasLoco.existingOrders.count)
        guard qty < hasLoco.maxDice else {
            throw OrderManagerError.locoDicePoolIsFull
        }
    }
    
}
