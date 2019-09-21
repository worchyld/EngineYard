//
//  Tax.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

struct Tax {
    private static let rate: Float = 0.10 // Players pay 10% of their cash in taxes, rounded down

    public static func due(onBalance: Int) -> Int {
        // Return rounded down amount
        return Int(floor(Float(onBalance) * Tax.rate))
    }

    public static func pay(onBalance: Int) -> Int {
        return Int(onBalance - due(onBalance: onBalance))
    }

    public static func getSalesTax(onBalance: Int) -> Int {
        let salesTax: Int = due(onBalance: onBalance)
        return Int(onBalance + salesTax)
    }
}
