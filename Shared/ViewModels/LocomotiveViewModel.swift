//
//  LocomotiveViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 07/03/2022.
//

import Foundation


// Used in the views

struct LocomotiveViewModel: Identifiable, Hashable, Equatable {
    let id: UUID
    let name: String
    let image: String
    let cost: Int
    var productionCost: Int {
        return Int(round(Double(self.cost) / 2))
    }
    var income: Int {
        return Int(round(Double(self.productionCost) / 2))
    }
    let capacity: Int // for dice
    let qty: Int // how many exist
    let orders: [Int]
    let sales: [Int]
    let livery: Livery
    let generation: Generation
    let rust: Rust
    let available: Bool
}
