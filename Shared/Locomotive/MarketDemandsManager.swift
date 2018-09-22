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

    /**
    (1) On first gen: with the oldest (lowest generation number) locomotive.
        (a) Place all dice from the Custo- mer Base and Existing Orders areas back in the dice pool.
        (b) This locomotive is obsolete
    (2) On middle gen:
        (a) If needed, add enough dice from the dice pool to the Customer Base to match the maximum number of dice for that locomotive.
        (b) Then roll all dice in the Customer Base and place them in the empty Existing Order boxes for that locomotive.
    (3) On third gen:
        (a)  If this locomotive does not have the maximum number of dice, add 1 die to the Cus- tomer Base from the dice pool.
        (b) Then all dice in the Customer Base are rolled and are placed in the empty Existing Order boxes for that locomotive type.
    **/

    private func handleThreeGenerations(decks:[Deck]) {
        assert(decks.count == 3, "\(#function) found \(decks.count)")

        for (index, element) in decks.enumerated() {
            switch index {
            case 0:
                element.orderBook.clear()
                element.markAsObsolete()
                break
            case 1:
                element.orderBook.fill(.completedOrder)
                element.orderBook.rerollAndTransferCompletedOrders()
                break
            case 2:
                element.orderBook.add(.completedOrder)
                element.orderBook.rerollAndTransferCompletedOrders()
                break
            default:
                break
            }

            print ("\(#function) \(element.description)")
        }
    }
}
