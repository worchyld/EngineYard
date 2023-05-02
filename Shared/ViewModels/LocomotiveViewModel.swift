//
//  LocomotiveViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 02/05/2023.
//

import Foundation

struct LocomotiveViewModel : Identifiable, Equatable {
    internal var id: UUID
    let name: String
    let generation: Generation
    let colour: EngineColor
    let cost: Int
    let productionCost: Int
    let income: Int
    let orders: [Int]
    let sales: [Int]
    let initialOrder: Int?
    let rust: Rust
    let trainPool: Int
    
    init(with loco: Locomotive) {
        self.id = loco.id
        self.name = loco.name
        self.generation = loco.generation
        self.colour = loco.colour
        self.cost = loco.cost
        self.productionCost = loco.productionCost
        self.income = loco.income
        self.orders = loco.existingOrders
        self.sales = loco.customerBase
        self.initialOrder = loco.initialOrder
        self.rust = loco.rust
        self.trainPool = loco.trainPool
    }
}
