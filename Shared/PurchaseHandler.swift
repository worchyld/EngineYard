//
//  PurchaseHandler.swift
//  EngineYardTests
//
//  Created by Amarjit on 30/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

/// Handles purchasing a train from the board
class PurchaseHandler {

    func purchase(train: Train, player: Player) throws {

        do {
            guard train.available else {
                throw TrainError(reason: .unavailable)
            }
            guard (train.rust != .rusted) else {
                throw TrainError(reason: .rusted)
            }

        }
        catch {
            throw error
        }


    }



    /**
    func purchase(player: Player) throws {
        do {

            let sameFamily = player.cards.filter({
                return $0.parent?.generation == train.generation &&
                    $0.parent?.livery == train.livery
                }).count

            if (sameFamily > 0) {
                throw CardError(reason: .sameFamily)
            }
            if let _ = player.cards.filter({ $0.owner == player }).first {
                throw CardError(reason: .alreadyOwnThisCard)
            }

            // deduct cash
            let wallet = Wallet()
            if try wallet.canDebit(account: player, amount: train.cost) {
               try wallet.debit(account: player, amount:  train.cost)
            }

            // Create factory production
            let fp = FactoryProduction.build(player, train, units: 1)

            // Add to player's hand
            self.add(card: fp, to: player)
        }
        catch {
            throw error
        }
    }
     **/
    private func add(card: FactoryProduction, to player: Player) {
        player.cards.append( card )
    }    
}
