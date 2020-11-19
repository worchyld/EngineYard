//
//  NumberFormatCache.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct NumberFormatCache {
    static let currencyRateFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.allowsFloats = false
        formatter.roundingMode = .ceiling
        formatter.alwaysShowsDecimalSeparator = false
        return formatter
    }()

    static let ordinalFormat: NumberFormatter = {
        let format = NumberFormatter()
        format.locale = Locale(identifier: "en_US")
        format.numberStyle = .ordinal
        format.maximumFractionDigits = 0
        format.allowsFloats = false
        format.roundingMode = .ceiling
        format.alwaysShowsDecimalSeparator = false
        return format
    }()
}

func cashFormat(player: Player) -> String {
    let number: NSNumber = NSNumber(integerLiteral: player.cash)
    let cache = NumberFormatCache.currencyRateFormatter
    return cache.string(from: number) ?? "$0"
}
