//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import Foundation

class EngineCard {
    let name: String
    let image: String
    let cost: Int
    let livery: Livery
    let generation: Generation
    let rust: Rust
    var available: Bool = false
    
    init(name: String = "", cost: Int, livery: Livery, generation: Generation) {
        self.name = name
        self.image = ""
        self.cost = cost
        self.livery = livery
        self.generation = generation
        self.rust = .notbuilt
        self.available = false
    }
}

struct Locomotive: Identifiable, Hashable, Equatable {
    let id: UUID
    let name: String
    let image: String
    let cost: Int
    let livery: Livery
    let generation: Generation
    let rust: Rust
    let available: Bool
}
