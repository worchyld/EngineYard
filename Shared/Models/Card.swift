//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import Foundation

class Card : TrainSpecificationDelegate {
    let name: String
    let image: String
    let cost: Int
    let livery: Livery
    let generation: Generation

    var orders: [Int] = [Int]()
    var sales: [Int] = [Int]()
        
    init(_ cost: Int, _ livery: Livery, _ generation: Generation) {
        self.cost = cost
        self.livery = livery
        self.image = livery.iconAsset
        self.generation = generation
        self.name = livery.description.lowercased() + "." + generation.description.lowercased()
    }
}
