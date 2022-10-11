//
//  D6.swift
//  EngineYard
//
//  Created by Amarjit on 02/10/2022.
//

import Foundation

protocol D6UseCases {
    mutating func increment()
    mutating func decrement()
    mutating func roll()
}

extension Int {
    public var isD6 : Bool {
        return (self >= Constants.D6.min && self <= Constants.D6.max)
    }
}

struct D6: Codable, Equatable, D6UseCases {
    public private (set) var value: Int

    init(with d6: D6?) {
        guard let die = d6 else {
            self.value = Die.roll
            return
        }
        self.value = die.value
    }

    public mutating func increment() {
        guard self.value < Constants.D6.max else {
            return
        }
        self.value += 1
    }

    public mutating func decrement() {
        guard self.value > Constants.D6.min else {
            return
        }
        self.value -= 1
    }
    
    public mutating func roll() {
        self.value = Die.roll
    }
}
