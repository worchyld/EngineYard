//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import Foundation

typealias Card = Locomotive

protocol LocomotiveDelegate {
    var id: UUID { get }
    var name: String { get }
    var image: String  { get }
    var cost: Int  { get }
    var livery: Livery  { get }
    var generation: Generation  { get }
    var rust: Rust  { get set }
    var available: Bool  { get set }
}

class Locomotive : LocomotiveDelegate {
    var id: UUID = UUID()
    
    let name: String
    let image: String
    let cost: Int
    let livery: Livery
    let generation: Generation
    let trainPool: Int
    let maxDice: Int
    var rust: Rust
    var orders: [Int] = [Int]()
    var sales: [Int] = [Int]()
    var available: Bool
    
    init(name: String, image: String, cost: Int, livery: Livery, generation: Generation, trainPool: Int, maxDice: Int) {
        self.name = name
        self.image = image
        self.cost = cost
        self.livery = livery
        self.generation = generation
        self.trainPool = trainPool
        self.maxDice = maxDice
        self.rust = .notbuilt
        self.available = false
    }
}


public enum LocomotiveOrdersErrorDelegate: Error, Equatable {
    case ordersAreFull
    case salesAreFull
}

extension Locomotive {
    
    // Add order
    
    func add(order: Int) throws {
        guard try canAdd(order: order) else {
            return
        }
        self.orders.append(order)
    }
    
    func canAdd(order: Int) throws -> Bool {
        guard (self.orders.count < self.maxDice) else {
            throw LocomotiveOrdersErrorDelegate.ordersAreFull
        }
        return true
    }
    
    // Add sale
    
    func add(sale: Int) throws {
        guard try canAdd(sale: sale) else {
            throw LocomotiveOrdersErrorDelegate.salesAreFull
        }
        self.sales.append(sale)
    }
    
    func canAdd(sale: Int) throws -> Bool {
        guard (self.sales.count < self.maxDice) else {
            throw LocomotiveOrdersErrorDelegate.salesAreFull
        }
        return true
    }
}

// In the game the orders pool of dice moves over to sales pool of dice
extension Locomotive {
    func transferToSales(order: Int) {
        
    }
    
    func transferToOrders(order: Int) {
        
    }
}
