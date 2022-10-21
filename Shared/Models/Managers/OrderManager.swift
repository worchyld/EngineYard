//
//  OrderManager.swift
//  EngineYard
//
//  Created by Amarjit on 21/10/2022.
//

import Foundation

enum OrderType : Int {
    case order
    case sale
}

enum OrderManagerError: Error {
    case isFull
    case rusted
    case notD6
}

class OrderManager {
    private var loco: Locomotive
    
    init(loco: Locomotive) {
        self.loco = loco
    }
    
    func add(orderType: OrderType, value: Int = 0) -> Result<Bool, OrderManagerError> {
        do {
            let value = try validate(value)
                        
            switch orderType {
            case .order:
                self.handleOrder(value: value)
                return .success(true)
            case .sale:
                self.handleSale(value: value)
                return .success(true)
            }
        } catch let err {
            return .failure(err as! OrderManagerError)
        }
    }
    
    func transferAll(to orderType: OrderType) {
        switch (orderType) {
        case .order:
            for (index, element) in loco.orders.enumerated() {
                loco.addSale(order: element)
                loco.orders.remove(at: index)
            }
        case .sale:
            for (index, element) in loco.sales.enumerated() {
                loco.addOrder(order: element)
                loco.sales.remove(at: index)
            }
        }
    }
    
    private func validate(_ value: Int = 0) throws -> Int {
        var value = value
        if (value == 0) {
            value = Die.roll
        }
        guard (value.isD6) else {
            throw OrderManagerError.notD6
        }
        guard (!loco.isFull) else {
            throw OrderManagerError.isFull
        }
        guard (loco.rust != .rusted) else {
            throw OrderManagerError.rusted
        }
        return value
    }
    
    private func handleOrder(value: Int) {
        loco.addOrder(order: value)
        // needs to handle notification of unlocking  next deck
    }
    
    private func handleSale(value: Int) {
        loco.addSale(order: value)
    }
}
