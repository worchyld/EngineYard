//
//  NumericError.swift
//  EngineYard
//
//  Created by Amarjit on 23/04/2023.
//

import Foundation

enum NumericError : Error {
    case resultIsNegative
    case mustBeGreaterThanZero
    case notEnough(amount: Int)
}

extension NumericError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .resultIsNegative:
            return NSLocalizedString("Cannot be a negative result", comment: "Numeric error: Result is negative")
        case .mustBeGreaterThanZero:
            return NSLocalizedString("Must be a positive number", comment: "Numeric error: Must be greater than 0")
        case .notEnough(let amount):
            return NSLocalizedString("You do not have enough to do this \(amount)", comment: "Numeric error: Not enough to do action")
        }
    }
}
