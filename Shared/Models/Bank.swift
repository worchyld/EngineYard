//
//  Bank.swift
//  EngineYard
//
//  Created by Amarjit on 21/10/2022.
//

import Foundation

class Bank {
    static func didTriggerEndOfGame(cash: Int) -> Bool {
        return (cash >= Constants.cashNeededToTriggerGameEnd)
    }
    
    // #TODO
    // Buy a card
    // 1. check hand, card is valid
    // 2. check funds
    // 3. add card to hand
    func buy(player: Player, card: Card) {
        guard let _ = card.loco else {
            return
        }
        if let _ = (player.hand.filter {
            return (
                ($0.loco!.generation == card.loco!.generation) &&
                ($0.loco!.livery == card.loco!.livery)
            )
        }.first) {
            return
        }
        let balance = player.balance
        let ok = Funds.debit(balance: balance, by: card.loco!.cost)
        switch ok {
        case .success(let newBalance):
            player.setCash(balance: newBalance)
        default:
            return
        }
        
        // Add card to players hand
        let handOk = player.handleCardAction(card: card, action: .pop(card: card))
        switch (handOk) {
        case .success:
            print ("success")
        case .failure(let err):
            print ("fail -- \(err)")
        }
    }

    // #TODO
    // Buy production units
    // 1. Check production is valid
    // 2. Check card is valid
    // 3. Check funds
    // 4. Update card production units
    func buy(player: Player, productionUnits: Int, card: Card) {
        guard productionUnits.isPositive else {
            return
        }
        let cost = (productionUnits * card.loco!.productionCost)
        let balance = player.balance
        let ok = Funds.debit(balance: balance, by: cost)
        switch ok {
        case .success(let newBalance):
            player.setCash(balance: newBalance)
        default:
            return
        }
        let result = card.production.execute(.addProductionUnits(productionUnits))
        card.setProduction(result)
    }

    func payTax(on players: [Player]) -> [Player] {
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
    
    
    
    func sortPlayersByCash(from players: [Player]) -> [Player]? {
        let sorted = players.sorted(by: { p1, p2 in
            return p1.balance > p2.balance
        })
        return sorted
    }
}
