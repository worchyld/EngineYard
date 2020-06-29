//
//  GameErrors.swift
//  EngineYard
//
//  Created by Amarjit on 29/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

/// Error type thrown by all of Files' throwing APIs.
public struct GameError<Reason>: Error {

    /// The reason that the error occured.
    public var reason: Reason

    /// Initialize an instance with a path and a reason.
    /// - parameter reason: The reason that the error occured.
    public init(reason: Reason) {
        self.reason = reason
    }
}

extension GameError: CustomStringConvertible {
    public var description: String {
        return """
        Encountered error'.
        Reason: \(reason)
        """
    }
}

/// Data specific errors
public enum DataErrorReason {
    /// The game data file is missing
    case missing
    /// The save failed
    case saveFailed
    /// The load failed
    case loadFailed
}


/// Errors for Board
public enum BoardErrorReason {
    /// The board is missing
    case missing
}


/// Enum listing reasons that a train manipulation could fail.
public enum TrainErrorReason {
    /// The train cannot be found
    case missing
    /// The train is not available
    case unavailable
    /// The train is rusted
    case rusted
    /// Has no initial order
    case noInitialOrder
    /// Has no existingOrders
    case noExistingOrders
    /// Has no completedOrders
    case noCompletedOrders
    /// The train is a younger generation than expected
    case youngerGeneration
    /// The train is the same livery
    case sameLivery
}

/// Enum listing reasons for card manipulation could fail
public enum CardErrorReason {
    /// The card cannot be found
    case missing
    /// The card is the same card
    case samecard
    /// The card is not owned by you
    case notyours
}

/// Enum listing reasons why production manipulation could fail
public enum ProductionErrorReason {
    /// The production cannot be negative
    case negative
    /// Not enough units, result could be negative
    case notEnoughProduction
    /// Cannot shift production from `origin` card to `destination` card
    case cannotShiftProduction
}

/// Enum listing reasons that cash/money manipulation could fail
public enum SpendingMoneyErrorReason {
    /// The amount spent cannot be negative
    case negative
    /// Must have enough to spend  amount
    case notEnoughFunds(amount: Int)
}

/// Error thrown by data operations - such as data is missing, cannot save, cannot load
public typealias DataError = GameError<DataErrorReason>
/// Error thrown by board operations - such as board is missing
public typealias BoardError = GameError<BoardErrorReason>

/// Error thrown by train operations - such as train is missing, unavailable, isRusted, hasNoOrders, etc
public typealias LocomotiveError = GameError<TrainErrorReason>
/// Error thrown by card operations - such as card is missing
public typealias CardError = GameError<CardErrorReason>
/// Error thrown by money/cash operations - such as not enough funds
public typealias SpendingMoneyError = GameError<SpendingMoneyErrorReason>
/// Error thrown by production - such as cannot spend negative production units
public typealias ProductionError = GameError<ProductionErrorReason>
