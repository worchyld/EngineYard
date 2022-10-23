//
//  Funds.swift
//  EngineYard
//
//  Created by Amarjit on 06/10/2022.
//

import Foundation

public enum FinanceError: Error, Equatable {
    case notEnough(funds: Int)
    case mustBePositive
}

extension FinanceError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notEnough(let funds):
            return NSLocalizedString("You do not have enough funds. $\(funds)", comment: "Finance error - Not enough funds")
        case .mustBePositive:
            return NSLocalizedString("Must a positive number", comment: "Finance error - Must be positive number")
        }
    }
}

public struct Funds {
    static func credit(balance: Int, with amount: Int) -> Result<Int, FinanceError> {
        return Transaction.make(.credit(balance: balance, withAmount: amount))
    }
    static func debit(balance: Int, by amount: Int) -> Result<Int, FinanceError> {
        return Transaction.make(.debit(balance: balance, byAmount: amount))
    }
}

private enum Transaction {
    case credit(balance: Int, withAmount: Int)
    case debit(balance: Int, byAmount: Int)
    
    static func make(_ t: Transaction) -> Result<Int, FinanceError> {
        do {
            let _ = try Transaction.validate(t)
                        
            switch t {
            case .credit(let balance, let amount):
                var balance = balance
                balance += amount
                return .success(balance)
                            
            case .debit(let balance, let amount):
                var balance = balance
                balance -= amount
                return .success(balance)
            }
        }
        catch let err {
            return .failure(err as! FinanceError)
        }
    }
    
}

extension Transaction {
    static func validate(_ transaction: Transaction) throws {
        switch (transaction) {
            
        case .credit(_, let amount):
            guard amount > 0 else {
                throw FinanceError.mustBePositive
            }
            
        case .debit(let balance, let amount):
            guard amount > 0 else {
                throw FinanceError.mustBePositive
            }
            guard balance > 0 else {
                throw FinanceError.notEnough(funds: balance)
            }
            guard balance >= amount else {
                throw FinanceError.notEnough(funds: balance)
            }
            let sum = (balance - amount)
            guard sum >= 0 else {
                throw FinanceError.notEnough(funds: balance)
            }
        }
    }
}
