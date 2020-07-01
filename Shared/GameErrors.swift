//
//  GameErrors.swift
//  EngineYard
//
//  Created by Amarjit on 29/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

/// Implement the `==` operator as required by protocol `Equatable`.
public func ==(lhs: Error, rhs: Error) -> Bool {
    return lhs._domain == rhs._domain
        && lhs._code   == rhs._code
}

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
public enum DataErrorReason : Equatable {
    /// The game data file is missing
    case missing
    /// The save failed
    case saveFailed
    /// The load failed
    case loadFailed
}


/// Errors for Board
public enum BoardErrorReason : Equatable {
    /// The board is missing
    case missing
}


/// Enum listing reasons that a train manipulation could fail.
public enum TrainErrorReason : Equatable {
    /// The train cannot be found
    case missing
    /// The train is not available
    case unavailable
    /// The train is rusting
    case rusting
    /// The train is rusted / obsolete
    case rusted
    /// No orders found
    case noOrders
    /// Orders are at capacity: See maxDice
    case ordersAreFull
    /// Already has initial order
    case alreadyHasInitialOrder
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
    /// No cards remain, all cards have owners
    case noCardsRemain
}

/// Enum listing reasons for card manipulation could fail
public enum CardErrorReason : Equatable {
    /// A specific card cannot be found
    case missingCard
    /// No cards can be found
    case noCardsFound
    /// The card is the same card
    case duplicateCard
    /// The card is not owned by you
    case notYours
    /// The card already owned by you
    case alreadyOwnThisCard
    /// You cannot own more than 1 card from family
    case sameFamily
    /// Your hand is empty
    case emptyHand
    /// Cannot add card
    case cannotAddCard
}

/// Enum listing reasons why production manipulation could fail
public enum ProductionErrorReason : Equatable {
    /// Production handler is missing
    case missingHandler
    /// The production has no factory parent
    case missingParent
    /// The production has no player owner
    case missingOwner
    /// This production is not yours
    case notYours
    /// The production cannot be negative
    case mustBePositive
    /// Not enough units, result could be negative
    case notEnoughProduction
    /// Cannot shift production from `origin` card to `destination` card
    case cannotShiftProduction
}

/// Enum listing reasons that cash/money manipulation could fail
public enum SpendingMoneyErrorReason : Equatable {
    /// The amount spent cannot be negative
    case mustBePositive
    /// Must have enough to spend  amount
    case notEnoughFunds(amount: Int)
}

/*
extension SpendingMoneyErrorReason : CustomStringConvertible {
    public var description: String {
        switch self {
        case .mustBePositive:
            return NSLocalizedString("Value cannot be negative", comment: "error.valueIsNegative")
        case .notEnoughFunds(let amount):
            return NSLocalizedString("Not enough funds to spend \(amount)", comment: "error.notEnoughFunds")
        }
    }
}*/

/// Error thrown by data operations - such as data is missing, cannot save, cannot load
public typealias DataError = GameError<DataErrorReason>
/// Error thrown by board operations - such as board is missing
public typealias BoardError = GameError<BoardErrorReason>

/// Error thrown by train operations - such as train is missing, unavailable, isRusted, hasNoOrders, etc
public typealias TrainError = GameError<TrainErrorReason>
/// Error thrown by card operations - such as card is missing
public typealias CardError = GameError<CardErrorReason>
/// Error thrown by production - such as cannot spend negative production units
public typealias ProductionError = GameError<ProductionErrorReason>
/// Error thrown by money/cash operations - such as not enough funds
public typealias SpendingMoneyError = GameError<SpendingMoneyErrorReason>
