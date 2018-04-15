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
        if (onBalance > 0) {
            return Int(onBalance - self.due(onBalance: onBalance))
        }
        return 0
    }

    // Tax is always rounded down (as per game rules)
    public static func due(onBalance: Int) -> Int {
        if (onBalance > 0) {
            return Int(floor(Float(onBalance) * Tax.rate))
        }
        return 0
    }

    // MARK: (Private)

    // Add tax to a given balance
    public static func add(toBalance: Int) -> Int {
        if (toBalance > 0) {
            let taxDue: Int = self.due(onBalance: toBalance)
            return Int(toBalance + taxDue)
        }
        return 0
    }

}
