//
//  OrderManager.swift
//  EngineYard
//
//  Created by Amarjit on 11/10/2022.
//

import Foundation

public enum OrderManagerError : Error {
    case ordersAreFull
    case salesAreFull
    case atCapacity
    case notAvailable
    case rusted
    case invalidOrderManager
    case valueIsNotD6(value: Int)
    //case cannotFindItemAtIndex(Int)
}

class OrderManager {
    func add(orderValue: Int, to loco: Locomotive) -> Result<Locomotive, OrderManagerError> {
        // Has it rusted?
        guard (loco.rust != Rust.rusted) else {
            let err = OrderManagerError.rusted
            return .failure(err)
        }
        // Is it available?
        guard (loco.isAvailable) else {
            let err = OrderManagerError.notAvailable
            return .failure(err)
        }
        // Is it full?
        guard (!loco.isFull) else {
            let err = OrderManagerError.atCapacity
            return .failure(err)
        }
        guard (orderValue.isD6) else {
            let err = OrderManagerError.valueIsNotD6(value: orderValue)
            return .failure(err)
        }
        
        let loco = loco.execute(.addOrder(order: orderValue))
        return .success(loco)
    }
    func add(sale: Int, to loco: Locomotive) -> Locomotive? {
        return nil
    }
}
