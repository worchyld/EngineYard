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

    private var board: Board

    init(board: Board) {
        self.board = board
    }

    func purchase(train: Train, player: Player) throws {

        do {
            // validate the train
            try validate(train: train)

            // create card
            let card : FactoryProduction = FactoryProduction.init(id: UUID(), units:  1)
            card.owner = player
            card.parent = train

            let hand = Hand(cards: player.cards)
            let wallet = Wallet()

            // can I afford it?
            guard try wallet.canAfford(player: player, train: train) else {
                throw SpendingMoneyError(reason: .notEnoughFunds(amount: train.cost))
            }
            // can I add it to my hand?
            guard try hand.canPush(card: card, set: player) else {
                throw CardError(reason: .cannotAddCard)
            }

            // add it to my hand
            try hand.willPush(card: card, assigning: player)

            // subtract cash from players wallet
            try wallet.purchased(card: card, owner: player)

            // notify the board to unlock the next train
//            guard let findIndex = board.firstIndex(of: train) else {
//                return
//            }
//            let nextIndex = board.index(after: findIndex)

            // count owners
            
        }
        catch {
            throw error
        }
    }

    internal func validate(train: Train) throws {
        guard train.available else {
            throw TrainError(reason: .unavailable)
        }
        guard (train.rust != .rusted) else {
            throw TrainError(reason: .rusted)
        }
    }
}


protocol HandPurchasedTrainUseCase : AnyObject {
    func canPush(card: Card, set owner: Player) throws -> Bool
    func willPush(card: Card, assigning owner: Player) throws
}

extension Hand : HandPurchasedTrainUseCase {

    internal func canPush(card: Card, set owner: Player) throws -> Bool {
        do {
            let hand = Hand(cards: owner.cards)
            return try hand.canPush(card)
        }
        catch {
            throw error
        }
    }

    internal func willPush(card: Card, assigning owner: Player) throws {
        do {
            let hand = Hand(cards: owner.cards)
            owner.cards = try hand.push(card)
        }
        catch {
            throw error
        }
    }
}

protocol PurchasedTrainDelegate {
    func purchased(card: Card, owner: Player) throws
    func canAfford(player: Player, train: Train) throws -> Bool
}

extension Wallet : PurchasedTrainDelegate {
    internal func purchased(card: Card, owner: Player) throws {
        do {
            guard let parent = card.parent else {
                throw CardError(reason: .missingCard)
            }
            let cost = parent.cost

            //let wallet = Wallet()
            return try self.debit(account: owner, amount: cost)
        }
        catch {
            throw error
        }
    }

    internal func canAfford(player: Player, train: Train) throws -> Bool {
        do {
            let cost = train.cost
            //let wallet = Wallet()
            return try self.canDebit(account: player, amount: cost)
        }
        catch {
            throw error
        }
    }
}
