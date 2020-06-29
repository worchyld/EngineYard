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

/// Enum listing reasons that a location manipulation could fail.
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
    /// An unresolved train operation failed with an underlying system error.
    case unresolved(Error)
}

public enum CardErrorReason {
    /// The card cannot be found
    case missing
    /// The card is the same card
    case samecard
    /// The card is not owned by you
    case notyours
}

public enum MoneyErrorReason {
    case notEnoughFunds(amount: Int)
}

/// Error thrown by train operations - such as train is missing, unavailable, isRusted, hasNoOrders, etc
public typealias LocomotiveError = GameError<TrainErrorReason>
/// Error thrown by card operations - such as card is missing
public typealias CardError = GameError<CardErrorReason>
/// Error thrown by money/cash operations - such as not enough funds
public typealias MoneyError = GameError<MoneyErrorReason>
