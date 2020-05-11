//
//  Tax.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

private protocol TaxProtocol {
    static func due(on amount: Int) -> Int
    static func pay(on amount: Int) -> Int
    static func add(on amount: Int) -> Int
}

struct Tax : TaxProtocol {
    static var rate: Float {
        return Constants.taxRate   // Players pay 10% of their cash in taxes, rounded down
    }

    // Finds out how much tax is due on an amount
    static func due(on amount: Int) -> Int {
        // Return rounded down amount as per game rules
        return Int(floor(Float(amount) * Tax.rate))
    }

    // Used to pay tax on an amount
    static func pay(on amount: Int) -> Int {
        return Int(amount - due(on: amount))
    }

    // Used to add a "sales tax" on some items
    static func add(on amount: Int) -> Int {
        let taxDue: Int = due(on: amount)
        return Int(amount + taxDue)
    }
}
