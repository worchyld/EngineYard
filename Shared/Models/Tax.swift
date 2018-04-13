//
//  Tax.swift
//  EngineYard
//
//  Created by Amarjit on 26/12/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

struct Tax
{
    // Subtract tax from a given balance
    public static func pay(onBalance: Int) -> Int {
        return Int(onBalance - self.calculateTaxDue(onBalance: onBalance))
    }

    // Tax is always rounded down (as per game rules)
    public static func calculateTaxDue(onBalance: Int) -> Int {
        return Int(floor(Float(onBalance) * Constants.taxRate))
    }

    // MARK: (Private) functions

    // Add tax to a balance
    public static func addSalesTax(toBalance: Int) -> Int {
        let salesTax: Int = self.calculateTaxDue(onBalance: toBalance)
        return Int(toBalance + salesTax)
    }

}
