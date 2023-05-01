//
//  Tax.swift
//  EngineYard
//
//  Created by Amarjit on 23/04/2023.
//

import Foundation

internal protocol TaxProtocol {
    static func due(on amount: Int) -> Int
    static func pay(on amount: Int) -> Int
}

struct Tax : TaxProtocol {
    // Players pay 10% of their cash in taxes, rounded down
    static var rate: Float {
        return Constants.taxRate
    }

    // Finds out how much tax is due on an amount
    // Return rounded down amount as per game rules
    static func due(on amount: Int) -> Int {
        guard (amount > 0) else { return 0 }
        return Int(floor(Float(amount) * Tax.rate))
    }

    // Used to pay tax on an amount
    static func pay(on amount: Int) -> Int {
        guard (amount > 0) else { return 0 }
        return Int(amount - Tax.due(on: amount))
    }
}
