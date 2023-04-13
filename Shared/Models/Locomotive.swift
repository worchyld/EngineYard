//
//  Locomotive.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation

struct Locomotive : Identifiable {
    let id: UUID
    let name : String
    let generation : Generation
    let colour : EngineColor
    let cost : Int
    var productionCost: Int {
        get {
            return Int(round(Double(self.cost) / 2))
        }
    }
    var income: Int {
        get {
            return Int(round(Double(self.productionCost) / 2))
        }
    }
}
