//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import Foundation

protocol LocomotiveProtocol {
    var name: String { get }
    var image: String { get }
    var cost: Int { get }
    var livery: Livery { get set }
    var generation: Generation { get set }
    var rust: Rust { get set }
    var available: Bool { get set }
}

class Locomotive : LocomotiveProtocol {
    var name: String
    var image: String
    var cost: Int
    var livery: Livery
    var generation: Generation
    var rust: Rust
    var available: Bool
    
    init(name: String, cost: Int, livery: Livery, generation: Generation) {
        self.name = name
        self.image = "" // tbc
        self.cost = cost
        self.livery = livery
        self.generation = generation
        self.rust = .notbuilt
        self.available = false
    }
}

