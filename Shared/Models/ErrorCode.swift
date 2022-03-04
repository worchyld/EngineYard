//
//  ErrorCode.swift
//  EngineYard
//
//  Created by Amarjit on 04/03/2022.
//

import Foundation

public enum ErrorCode : Error {
    case noGameObject, noBoardDefined, noPlayerFound
}

extension ErrorCode : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noBoardDefined:
            return NSLocalizedString("** No board defined **", comment: "System-error: No board defined")
        case .noGameObject:
            return NSLocalizedString("** No game defined **", comment: "System-error: No game object")
        case .noPlayerFound:
            return NSLocalizedString("** No player found **", comment: "System-error: No player found")
        }
    }
}
