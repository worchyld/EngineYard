//
//  Tax.swift
//  EngineYard
//
//  Created by Amarjit on 13/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

struct Tax
{
    private static let rate : Float = 0.10

    // Subtract tax from a given balance
    public static func pay(onBalance: Int) -> Int {
        return Int(onBalance - self.calculateTaxDue(onBalance: onBalance))
    }

    // Tax is always rounded down (as per game rules)
    public static func calculateTaxDue(onBalance: Int) -> Int {
        return Int(floor(Float(onBalance) * Tax.rate))
    }

    // MARK: (Private) functions

    // Add tax to a given balance
    public static func add(toBalance: Int) -> Int {
        let taxDue: Int = self.calculateTaxDue(onBalance: toBalance)
        return Int(toBalance + taxDue)
    }

}
