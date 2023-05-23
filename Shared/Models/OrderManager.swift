//
//  OrderManager.swift
//  EngineYard
//
//  Created by Amarjit on 16/04/2023.
//

import Foundation

enum OrderManagerError : Error {
    case noLoco
    case cannotSetInitialOrder
    case hasNoInitialOrder
    case mustBeActive
    case hasRusted
    case noOrderValue
}

extension OrderManagerError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noLoco:
            return NSLocalizedString("No locomotive found", comment: "Order error: No Loco")
        case .cannotSetInitialOrder:
            return NSLocalizedString("Cannot set initial order for this locomotive", comment: "Order error: Cannot set initial order")
        case .hasNoInitialOrder:
            return NSLocalizedString("Locomotive has no initial order", comment: "Order error: Needs an initial order")
        case .mustBeActive:
            return NSLocalizedString("Locomotive must be active", comment: "Active not rusted")
        case .hasRusted:
            return NSLocalizedString("Locomotive has rusted", comment: "Order error: Has rusted")
        case .noOrderValue:
            return NSLocalizedString("No order value set", comment: "Order error: No order value")
        }
    }
}

/*
 Handles order management
 + Set the initial order only if its not built
 + Add an order only if its active & not rusted
 + Add a sales value only if its active & not rusted
 + Transfer all sales -> orders only if its active & not rusted
 */
class OrderManager: Rollable {
    private var loco: Locomotive
    
    init(loco: Locomotive) {
        self.loco = loco
    }
    
    internal func roll() -> Int {
        return D6.roll
    }
    
    func addInitialOrder() throws {
        guard loco.rust == .notBuilt else {
            throw OrderManagerError.cannotSetInitialOrder
        }

        self.loco.initialOrder = roll()
        self.loco.rustify()
    }
    
    func addOrder(value: Int = 0) throws {
        guard loco.rust.isActive else {
            throw OrderManagerError.mustBeActive
        }
        
        var order: Int
        
        if (value == 0) {
            order = roll()
            self.loco.orders.append(order)
        } else {
            if (!value.isD6) {
                throw NumericError.notAValidD6
            }
            else {
                self.loco.orders.append(value)
            }
        }
    }
    
    func addSale(value: Int) throws {
        guard value.isPositive else {
            throw NumericError.mustBeGreaterThanZero
        }
        guard loco.rust.isActive else {
            throw OrderManagerError.mustBeActive
        }
        self.loco.sales.append(value)
    }

    func transferOrderToSale() throws {
        guard self.loco.isActive else {
            throw OrderManagerError.mustBeActive
        }
        
        // Find the item, move it to the sales array, then remove from orders array
        //self.loco.sales.append(value)
        //self.loco.orders.remove(at: index)
    }
    
    func transferAllSalesToOrders() throws {
        guard self.loco.isActive else {
            throw OrderManagerError.mustBeActive
        }
    
        do {
            let _ = try self.loco.sales.enumerated().map { index, item in
                try self.addOrder(value: item)
            }
            self.loco.sales.removeAll()
            
        } catch let err {
            throw err
        }
    }
}
