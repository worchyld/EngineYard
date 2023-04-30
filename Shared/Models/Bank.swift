//
//  Bank.swift
//  EngineYard
//
//  Created by Amarjit on 23/04/2023.
//

import Foundation

class Bank {
    
    enum Transaction {
        case credit(balance: Int, amount: Int)
        case debit(balance: Int, amount: Int)
        
        static func execute(_ t: Transaction) -> Result<Int, NumericError> {
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
                return .failure(err as! NumericError)
            }
        }
        
        static func validate(_ transaction: Transaction) throws {
            switch (transaction) {
            case .credit(_, let amount):
                guard amount > 0 else {
                    throw NumericError.mustBeGreaterThanZero
                }
                
            case .debit(let balance, let amount):
               guard amount > 0 else {
                   throw NumericError.mustBeGreaterThanZero
               }
               guard balance > 0 else {
                   throw NumericError.notEnough(amount: balance)
               }
               guard balance >= amount else {
                   throw NumericError.notEnough(amount: balance)
               }
               let sum = (balance - amount)
               guard sum >= 0 else {
                   throw NumericError.notEnough(amount: balance)
               }
                
            }
        }
    }

    
    func buyTrain() {
        
    }
    
    func buyProduction() {
        
    }
    
    func payTax(players: [Player]) {
        for p in players {
            let cash = p.cash
            let due = Tax.calculate(on: cash)
            let sum = Tax.pay(on: cash)
            
            print ("Cash: $\(cash)")
            print ("Due: $\(due)")
            print ("Sum: $\(sum)\n\r")
        }
    }
}
