//
//  ErrorCode.swift
//  EngineYard
//
//  Created by Amarjit on 04/03/2022.
//

import Foundation

public enum GameErrorDelegate: Error {
    case noGameObject, noBoardDefined, noPlayerFound, noGenerationFound, noLiveryFound
}

public enum NumericErrorDelegate: Error, Equatable {
    case cannotBeNegative
    case notEnoughFunds
    case cannotCover(_ amount: Int)
}

public enum DicePoolError: Error {
    case poolIsFull
}


// Descriptions

extension GameErrorDelegate : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noBoardDefined:
            return NSLocalizedString("** No board defined **", comment: "System-error: No board defined")
        case .noGameObject:
            return NSLocalizedString("** No game defined **", comment: "System-error: No game object")
        case .noPlayerFound:
            return NSLocalizedString("** No player found **", comment: "System-error: No player found")
        case .noGenerationFound:
            return NSLocalizedString("** No train generation found **", comment: "System-error: No train generation found")
        case .noLiveryFound:
            return NSLocalizedString("** No train livery found **", comment: "System-error: No train livery found")
        }
    }
}


extension NumericErrorDelegate : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cannotBeNegative:
            return NSLocalizedString("Number cannot be negative", comment: "Numeric error")
        case .notEnoughFunds:
            return NSLocalizedString("Not enough funds", comment: "Numeric error")
        case .cannotCover:
            return NSLocalizedString("Cannot cover amount", comment: "Numeric error")
        }
    }
}

extension DicePoolError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .poolIsFull:
            return NSLocalizedString("The dice pool is full", comment: "The dice pool for the train is full")
        }
    }
}
