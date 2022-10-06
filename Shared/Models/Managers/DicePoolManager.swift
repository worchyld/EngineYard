//
//  DicePoolManager.swift
//  EngineYard
//
//  Created by Amarjit on 02/10/2022.
//

import Foundation

enum DieDestination {
    case orders, sales
}

class DicePool {
    private var _orders: [Int]?
    private var _sales: [Int]?
    private var capacity: Int
    
    public var orders: [Int] {
        return self._orders ?? [Int]()
    }
    public var sales: [Int] {
        return self._sales ?? [Int]()
    }
    
    init(with orders: [Int]? = nil, sales: [Int]? = nil, capacity: Int) {
        self.capacity = capacity
        self._orders = orders
        self._sales = sales
    }
    
    public var isAtCapacity: Bool {
        let sum = self.orders.count + self.sales.count
        return sum <= self.capacity
    }
}

