//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation

// Each train has these 3 common things
protocol TrainSpecificationDelegate {
    var cost: Int  { get }
    var livery: Livery  { get }
    var generation: Generation  { get }
}

class Deck : TrainSpecificationDelegate {
    private var name: String
    var cards: [Card] = [Card]()    
    let cost: Int
    let maxDice: Int
    let livery: Livery
    let generation: Generation
    var rust: Rust = .notbuilt
    var available: Bool = false
    
    init(_ cost: Int, _ livery: Livery, _ generation: Generation, _ maxDice: Int) {
        self.name = UUID().uuidString
        self.cost = cost
        self.maxDice = maxDice
        self.livery = livery
        self.generation = generation
        self.rust = .notbuilt
        self.available = false
    }
}
