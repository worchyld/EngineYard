//
//  Generation.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum Generation: Int, Codable, CaseIterable {
    case first = 1, second, third, fourth, fifth
}

// Ordinal description extension
extension Generation {
    var ordinalFormat: String? {
        let number: NSNumber = NSNumber(integerLiteral: self.rawValue)
        let cache = NumberFormatCache.ordinalFormat
        return cache.string(from: number)
    }
}
