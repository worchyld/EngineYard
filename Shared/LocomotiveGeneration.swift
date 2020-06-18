//
//  LocomotiveGeneration.swift
//  EngineYard
//
//  Created by Amarjit on 18/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

extension Locomotive {
    public enum Generation: Int, CaseIterable {
        case first = 1, second, third, fourth, fifth

        static let allRawValues = Locomotive.Generation.first.rawValue...Locomotive.Generation.fifth.rawValue
    }
}

// Ordinal description extension
extension Locomotive.Generation {
    var ordinalFormat: String? {
        let number: NSNumber = NSNumber(integerLiteral: self.rawValue)
        let cache = NumberFormatCache.ordinalFormat
        return cache.string(from: number)
    }
}
