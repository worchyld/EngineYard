//
//  Tax.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import Foundation

private protocol TaxProtocol {
    static func calculate(on amount: Int) -> Int
    static func pay(on amount: Int) -> Int
    static func add(on amount: Int) -> Int
}

struct Tax : TaxProtocol {
    // Players pay 10% of their cash in taxes, rounded down
    static var rate: Float {
        return Constants.taxRate
    }

    // Finds out how much tax is due on an amount
    // Return rounded down amount as per game rules
    static func calculate(on amount: Int) -> Int {
        guard (amount > 0) else { return 0 }
        return Int(floor(Float(amount) * Tax.rate))
    }

    // Used to pay tax on an amount
    static func pay(on amount: Int) -> Int {
        guard (amount > 0) else { return 0 }
        return Int(amount - calculate(on: amount))
    }

    // Used to add a "sales tax" on some items
    static func add(on amount: Int) -> Int {
        guard (amount > 0) else { return 0 }
        let taxDue: Int = calculate(on: amount)
        return Int(amount + taxDue)
    }
}
