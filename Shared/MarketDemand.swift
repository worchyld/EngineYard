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
    lazy var decks: [Deck]? = {
        guard let decks = board as? [Deck] else {
            return nil
        }
        return decks
    }()
    private(set) var howManyGenerationsExist: Int = 0


//    lazy var marketForPassengerLocomotives: Int = {
//        let filter = self.marketFor(locomotiveType: .green)
//        return filter.count
//    }()
//    lazy var marketForFastLocomotives: Int = {
//        let filter = self.marketFor(locomotiveType: .red)
//        return filter.count
//    }()
//    lazy var marketForFreightLocomotives: Int = {
//        let filter = self.marketFor(locomotiveType: .yellow)
//        return filter.count
//    }()
//    lazy var marketForSpecialLocomotives: Int = {
//        let filter = self.marketFor(locomotiveType: .blue)
//        return filter.count
//    }()

    init(board: Board) {
        self.board = board
    }

    // Determine how many generations of that locomotive type currently exist.
    //   A generation exists if there are dice in either the `existingOrders` (Existing Orders)
    //   boxes or the `completedOrders` (Customer Base) boxes or in both.

    func start() {
    }
}

extension MarketDemand {

    /* New Existing Orders for marketable locomotives are determined
     It consists of four steps, each step dedicated to one locomotive type:
        1. Market for Passenger locomotives (green)
        2. Market for Fast locomotives (red)
        3. Market for Freight locomotives (yellow)
        4. Market for Special locomotives (blue)
     */
    internal func marketFor(locomotiveType: Family.Color) -> [Deck] {
        guard let decks = self.decks else {
            return [] // empty array
        }

        // Find all decks that match the type & have orders,
        // sorted by cost & generation ascending
        let filter = decks.filter { (deck: Deck) -> Bool in
            return (deck.color == locomotiveType && deck.orders.count > 0)
        }.sorted { (a: Deck, b: Deck) -> Bool in
            return ((a.cost < b.cost) && (a.generation.rawValue < b.generation.rawValue))
        }

        self.howManyGenerationsExist = filter.count

        return filter
    }

}
