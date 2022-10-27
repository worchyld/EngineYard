//
//  ErrorCode.swift
//  EngineYard
//
//  Created by Amarjit on 04/03/2022.
//

import Foundation

public enum GameErrorDelegate: Error {
    case noGameObject, noBoardDefined, noTrainFound, notEnoughCardsInDeck, noPlayerFound, noGenerationFound, noLiveryFound
}

public enum NumberErrorDelegate: Error, Equatable {
    case cannotBeNegative
}


// Descriptions

extension GameErrorDelegate : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noBoardDefined:
            return NSLocalizedString("** No board defined **", comment: "System-error: No board defined")
        case .noTrainFound:
            return NSLocalizedString("** No train found **", comment: "System-error: No train found")
        case .noGameObject:
            return NSLocalizedString("** No game defined **", comment: "System-error: No game object")
        case .notEnoughCardsInDeck:
            return NSLocalizedString("** Not enough cards in deck **", comment: "System-error: Not enough cards")
        case .noPlayerFound:
            return NSLocalizedString("** No player found **", comment: "System-error: No player found")
        case .noGenerationFound:
            return NSLocalizedString("** No train generation found **", comment: "System-error: No train generation found")
        case .noLiveryFound:
            return NSLocalizedString("** No train livery found **", comment: "System-error: No train livery found")
        }
    }
}


extension NumberErrorDelegate : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cannotBeNegative:
            return NSLocalizedString("Number cannot be negative", comment: "Numeric error")
        }
    }
}
