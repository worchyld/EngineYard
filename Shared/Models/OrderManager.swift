//
//  OrderManager.swift
//  EngineYard
//
//  Created by Amarjit on 16/04/2023.
//

import Foundation

enum OrderManagerError : Error {
    case noLoco
    case initialOrderError
}

class OrderManager: Rollable {
    private weak var loco: Locomotive?
    
    init(loco: Locomotive? = nil) {
        self.loco = loco
    }
    
    func roll() -> Int {
        return D6.roll
    }
    
    func addInitialOrder() throws {
        do {
            let loco = try locoIsNotNil()
            try canSetInitialOrder(loco: loco)
            loco.initialOrder = roll()
            loco.rustify()
        } catch let err {
            throw err
        }
    }
    
    func addOrder() throws {
        do {
            let loco = try locoIsNotNil()
            
            print ("loco : \(loco)")
            
        } catch let err {
            throw err
        }
    }
    
    internal func locoIsNotNil() throws -> Locomotive {
        guard let loco = self.loco else {
            throw OrderManagerError.noLoco
        }
        return loco
    }
    
    internal func canSetInitialOrder(loco: Locomotive) throws {
        guard loco.rust == .notBuilt else {
            throw OrderManagerError.initialOrderError
        }
    }
}
