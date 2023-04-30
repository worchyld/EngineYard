//
//  Wallet.swift
//  EngineYard
//
//  Created by Amarjit on 17/04/2023.
//

import Foundation

class Wallet {
    private var balance: Int
    
    init(balance: Int = 0) {
        self.balance = balance
    }
    
    func add(_ amount: Int = 0) throws -> Int {
        let result = Bank.Transaction.execute(.credit(balance: self.balance, amount: amount))
        switch result {
        case .failure(let err):
            throw err
        case .success(let newBalance):
            self.balance = newBalance
        }
        return self.balance
    }
    
    func subtract(_ amount: Int = 0) throws -> Int {
        let result = Bank.Transaction.execute(.debit(balance: self.balance, amount: amount))
        switch result {
        case .failure(let err):
            throw err
        case .success(let newBalance):
            self.balance = newBalance
        }
        
        return self.balance
    }
}
