//
//  Bank.swift
//  EngineYard
//
//  Created by Amarjit on 21/10/2022.
//

import Foundation

class Bank {
        
    func canAffordLocomotive(_ loco: Locomotive, funds: Int) -> Bool {
        return canAfford(cost: loco.cost, balance: funds)
    }
    
    func canAffordProduction(_ units: Int, loco: Locomotive, player: Player) -> Bool {
        guard (units.isPositive) else { return false }
        let cost = (units * loco.productionCost)
        return canAfford(cost: cost, balance: player.balance)
    }

    static func didTriggerEndOfGame(cash: Int) -> Bool {
        return (cash >= Constants.cashNeededToTriggerGameEnd)
    }
    
    func sortPlayersByCash(from players: [Player]) -> [Player]? {
        let sorted = players.sorted(by: { p1, p2 in
            return p1.balance > p2.balance
        })
        return sorted
    }
    
    static func payTax(on players: [Player]) -> [Player] {
        let _ = players.map {
            let taxDue = Tax.calculate(on: $0.balance)
            let result = Funds.debit(balance: $0.balance, by: taxDue)
            switch (result) {
            case .success(let newBalance):
                $0.setCash(balance: newBalance)
            case .failure(_):
                break
            }
        }
        return players
    }
    
    
    private func canAfford(cost: Int, balance: Int) -> Bool {
        guard (balance >= cost) else {
            return false
        }
        return true
    }
    
}
