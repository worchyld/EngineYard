//
//  Funds.swift
//  EngineYard
//
//  Created by Amarjit on 06/10/2022.
//

import Foundation

public enum FundingError: Error, Equatable {
    case notEnough(funds: Int)
    case mustBePositive
}

public struct Funds {
    static func credit(balance: Int, with amount: Int) -> Result<Int, FundingError> {
        return Transaction.make(.credit(balance: balance, withAmount: amount))
    }
    static func debit(balance: Int, by amount: Int) -> Result<Int, FundingError> {
        return Transaction.make(.debit(balance: balance, byAmount: amount))
    }
}

private enum Transaction {
    case credit(balance: Int, withAmount: Int)
    case debit(balance: Int, byAmount: Int)
    
    static func make(_ t: Transaction) -> Result<Int, FundingError> {
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
            return .failure(err as! FundingError)
        }
    }
    
}

extension Transaction {
    static func validate(_ transaction: Transaction) throws {
        switch (transaction) {
            
        case .credit(_, let amount):
            guard amount > 0 else {
                throw FundingError.mustBePositive
            }
            
        case .debit(let balance, let amount):
            guard amount > 0 else {
                throw FundingError.mustBePositive
            }
            guard balance > 0 else {
                throw FundingError.notEnough(funds: balance)
            }
            guard balance >= amount else {
                throw FundingError.notEnough(funds: balance)
            }
            let sum = (balance - amount)
            guard sum >= 0 else {
                throw FundingError.notEnough(funds: balance)
            }
        }
    }
}
