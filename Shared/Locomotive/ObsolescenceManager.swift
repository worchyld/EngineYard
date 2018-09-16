//
//  ObsolescenceManager.swift
//  EngineYard
//
//  Created by Amarjit on 16/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

struct ObsolescenceManager {

    private var _decks: [Deck]

    init(decks: [Deck]) {
        self._decks = decks
    }

    func getGenerations(for color: EngineColor) -> [Deck]? {
        guard let generations = Board.findActiveGenerations(in: _decks, color: color) else {
            return nil
        }

        print ("Found: \(generations.count) generations")

        return generations
    }

    func handleGenerations(for color: EngineColor) {
        guard let generations = getGenerations(for: color) else {
            return
        }
        print ("Checking \(color):")
        switch generations.count {
        case 0:
            print ("0 gens found. Do nothing")
            self.handleOneGeneration(decks: generations)
            break
        case 1:
            print ("1 gens found")
            break

        case 2:
            print ("2 gens found")
            break

        case 3:
            print ("3 gens found")
            break

        default:
            print ("\(generations.count) gens found. Outside of scope, exiting.")
            break
        }
    }

    private func handleOneGeneration(decks:[Deck]) {
        guard let firstDeck = decks.first else {
            return
        }
        if (!firstDeck.orderBook.hasMaximumDice) {
            print ("add 1 order")
        }
        print ("roll all sales, move to orders")
        //firstDeck.orderBook.rerollAndTransferCompletedOrders()
    }

}
