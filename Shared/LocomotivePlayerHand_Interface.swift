//
//  LocomotivePlayerHand_Interface.swift
//  EngineYard
//
//  Created by Amarjit on 14/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// The interface between a locomotive object
//  a player's hand object
//  and the card to be added to player's hand
class LocomotivePlayerHand_Interface {
    private var locomotive: Locomotive
    private var player: Player
    private var hand: Hand

    init(locomotive: Locomotive, player: Player) {
        self.locomotive = locomotive
        self.player = player
        if (!self.player.hand.isEmpty) {
            self.hand = Hand.init(self.player.hand)
        }
        else {
            self.hand = Hand.init()
        }
    }
}

extension LocomotivePlayerHand_Interface {
    func add() throws {
        do {
            guard let card = try findFirstUnownedCard() else {
                throw HandError.locomotiveIsNotAvailable
            }
            self.hand = try push(card)
            didPush()
        } catch {
            throw error
        }
    }

    private func push(_ card: Card) throws -> Hand {
        do {
            try hand.add(card)
            return self.hand
        } catch {
            throw error
        }
    }

    private func didPush() {
        self.player.setHand(cards: hand.cards)
    }

    func findFirstUnownedCard() throws -> Card? {
        if locomotive.cards.isEmpty {
            throw HandError.locomotiveHasNoCards
        }
        switch locomotive.state {
        case .obsolete:
            throw HandError.locomotiveIsObsolete
        case .old:
            throw HandError.locomotiveIsOld
        case .unavailable:
            throw HandError.locomotiveIsNotAvailable

        default:
            break
        }

        // A player may develop only a locomotive that has either 1 die in the Initial Orders area or one or more dice in the Existing Orders boxes.
        let orders = locomotive.orders.filter { (o: Order) -> Bool in
            return (o.state == .initialOrder || o.state == .existingOrder)
        }
        if ((orders.isEmpty) || (orders.count > 0)) {
            throw HandError.locomotiveIsNotAvailable
        }

        guard let filter = try locomotive.cards.filter({ (card: Card) -> Bool in
            return try self.hand.canAdd(card)
        }).first else {
            throw HandError.locomotiveIsNotAvailable
        }

        return filter
    }
}
