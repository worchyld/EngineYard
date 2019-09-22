//
//  ErrorCode.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

public enum ErrorCode: Error {
    case noGameObjectDefined
    case noGameBoardDefined
    case noPlayerFound
    case invalidNumberOfPlayers
    case notYourTurn    

}


extension ErrorCode {
    public var localizedDescription: String {
        switch self {
        case .noGameObjectDefined:
            return NSLocalizedString("** No game object defined **", comment: "System-error: No game object defined message")

        case .noGameBoardDefined:
            return NSLocalizedString("** No game board defined **", comment: "System-error: No game board defined message")

        case .noPlayerFound:
            return  NSLocalizedString("No player found", comment: "noPlayerFound message")


        case .invalidNumberOfPlayers:
            return  NSLocalizedString("Invalid number of players", comment: "invalidPlayers message")

        case .notYourTurn:
            return  NSLocalizedString("It is not your turn", comment: "notYourTurn message")
        }
    }
}
