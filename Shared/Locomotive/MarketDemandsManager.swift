//
//  MarketDemandsManager.swift
//  EngineYard
//
//  Created by Amarjit on 16/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

struct MarketDemandsManager {

    private var _decks: [Deck]

    init(decks: [Deck]) {
        self._decks = decks
    }

    func getGenerations(for color: EngineColor) -> [Deck]? {
        guard let generations = Board.findActiveGenerations(in: _decks, color: color) else {
            return nil
        }

        return generations
    }

    func handleGenerations(for color: EngineColor) {
        guard let generations = getGenerations(for: color) else {
            return
        }
        switch generations.count {
        case 0:
            break
        case 1:
            self.handleOneGeneration(decks: generations)
            break

        case 2:
            self.handleTwoGenerations(decks: generations)
            break

        case 3:
            self.handleThreeGenerations(decks: generations)
            break

        default:
            break
        }
    }

    private func handleOneGeneration(decks:[Deck]) {
        guard let firstDeck = decks.first else {
            return
        }
        firstDeck.orderBook.rerollAndTransferCompletedOrders()
        if (!firstDeck.orderBook.hasMaximumDice) {
            firstDeck.orderBook.add(.existingOrder)
        }
        print ("\(#function) firstDeck.orderBook = \(firstDeck.orderBook.description)")
    }

    /*
    (1) Begin with oldest deck:
     (a) Transfer one of the dice from the Customer Base to the dice pool.
     (b) Then roll any remaining dice in the Customer Base and place them in the empty Existing Order boxes for that locomotive.
     (c) This locomotive is considered old.
    (2) The newer generation is now checked
     (a) If not max dice, add order
     (b) Transfer sales -> orders
     */
    private func handleTwoGenerations(decks:[Deck]) {
        for (index, element) in decks.enumerated() {
            if (index == 0) {
                element.orderBook.removeFirstCompletedOrder()
                element.orderBook.rerollAndTransferCompletedOrders()
                element.markAsOld()
            }
            else {
                element.orderBook.rerollAndTransferCompletedOrders()
                if (!element.orderBook.hasMaximumDice) {
                    element.orderBook.add(.existingOrder)
                }
            }
            print ("\(#function) \(element.name) = \(element.orderBook.description)")
        }
    }

    private func handleThreeGenerations(decks:[Deck]) {
    }
}
