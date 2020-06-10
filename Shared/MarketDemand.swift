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

    // Determine how many generations of that locomotive type currently exist.
    //   A generation exists if there are dice in either the `existingOrders` (Existing Orders)
    //   boxes or the `completedOrders` (Customer Base) boxes or in both.
    func howManyGenerationsExist(of type: Family.Color, board: Board) -> Int {

        for deck in board {
            print (deck?.color as Any)
        }

        let filter = board.filter { (d) -> Bool in
            guard let deck = d else {
                return false
            }
            guard (deck.orders.count > 0) else {
                return false
            }
            return true
        }.reduce(0, {
            //$0 + $1?.generation.rawValue
            guard let generation = $1?.generation else {
                return 0
            }
            return ($0 + generation.rawValue)
        })

        print ("Filter: \(filter)")

        return filter
    }


}
