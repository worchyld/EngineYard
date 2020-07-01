//
//  Tax.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

private protocol TaxProtocol {
    static func due(on amount: Int) -> Int
    static func pay(on amount: Int) -> Int
    static func add(on amount: Int) -> Int
}

struct Tax : TaxProtocol {
    // Players pay 10% of their cash in taxes, rounded down
    static let rate: Float = 0.10

    // Finds out how much tax is due on an amount
    // Return rounded down amount as per game rules
    static func due(on amount: Int) -> Int {
        guard (amount > 0) else { return 0 }
        return Int(floor(Float(amount) * Tax.rate))
    }

    // Used to pay tax on an amount
    static func pay(on amount: Int) -> Int {
        guard (amount > 0) else { return 0 }
        return Int(amount - due(on: amount))
    }

    // Used to add a "sales tax" on some items
    static func add(on amount: Int) -> Int {
        guard (amount > 0) else { return 0 }
        let taxDue: Int = due(on: amount)
        return Int(amount + taxDue)
    }
}
