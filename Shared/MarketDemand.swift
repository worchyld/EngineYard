//
//  MarketDemand.swift
//  EngineYard
//
//  Created by Amarjit on 10/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Handles market demands phase.

// In this phase, new Existing Orders for marketable locomotives are determined and Existing Orders
//   for old and obsolete locomotives are cancelled.
//    It consists of four steps, each step dedicated to one locomotive type: (green, red, yellow, blue)
//

class MarketDemand {
    private var board: Board

    init(board: Board) {
        self.board = board
    }

    // Determine how many generations of that locomotive type currently exist.
    //   A generation exists if there are dice in either the `existingOrders` (Existing Orders)
    //   boxes or the `completedOrders` (Customer Base) boxes or in both.

    func start() {
        for familyColor in Family.Color.allCases.enumerated() {
            self.handle(color: familyColor.element)
        }
    }

    private func handle(color: Family.Color) {
        print ("handle: \(color as Any)")
        guard let filteredDecks = Deck.filterOrders(in: board, matching: color) else {
            print ("No orders found, do nothing")
            return
        }
        let exists = Deck.totalGenerations(in: filteredDecks)
        
        switch exists {
        case 1: // 1 generation exist
            handleOneGeneration( decks: filteredDecks )

        case 2: // 2 generations exist
            handleTwoGenerations(decks: filteredDecks)

        case 3: // 3 generations exist
            handleThreeGenerations(decks: filteredDecks)

        default:
            // do nothing
            return
        }
    }

    private func handleOneGeneration(decks: [Deck?]) {
        guard let decks = decks as? [Deck] else {
            return
        }

        print("handleOneGen: \(decks)")
    }

    private func handleTwoGenerations(decks: [Deck?]) {
        guard let decks = decks as? [Deck] else {
            return
        }

        print("handleTwoGenerations: \(decks)")
    }

    private func handleThreeGenerations(decks: [Deck?]) {
        guard let decks = decks as? [Deck] else {
            return
        }

        print("handleThreeGenerations: \(decks)")
    }
}
