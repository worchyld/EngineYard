//
//  Funds.swift
//  EngineYard
//
//  Created by Amarjit on 06/10/2022.
//

import Foundation

public enum FundingError: Error {
    case notEnough(funds: Int)
    case mustBePositive
}

public enum Funds {
    case credit(balance: Int, withAmount: Int)
    case debit(balance: Int, byAmount: Int)
    
    func transaction(f: Funds) -> Result<Int, FundingError> {
        do {
            let _ = try Funds.validate(f: f)
            
            
            switch self {
            case .credit(let balance, let amount):
                return self.handleCredit(balance: balance, with: amount)
                            
            case .debit(let balance, let amount):
                return self.handleDebit(balance: balance, by: amount)
            }
        }
        catch let err {
            return .failure(err as! FundingError)
        }
    }
    
    private func handleCredit(balance: Int, with amount: Int) -> Result<Int, FundingError> {
        var balance = balance
        balance += amount
        return .success(balance)
    }
    
    private func handleDebit(balance: Int, by amount: Int) -> Result<Int, FundingError> {
        var balance = balance
        balance -= amount
        return .success(balance)
    }
}

extension Funds {
    static func validate(f: Funds) throws {
        switch (f) {
            
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
