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
        guard self.value < 6 else {
            return
        }
        self.value += 1
    }

    public mutating func decrement() {
        guard self.value > 1 else {
            return
        }
        self.value -= 1
    }
}
