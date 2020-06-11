//
//  MarketDemand.swift
//  EngineYard
//
//  Created by Amarjit on 10/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

/*
 *Market demands handler*

 In this phase, new existing orders for marketable locomotives
 are determiened and existing orders for old and obsolete locomotives
 are cancelled.

 It consists of obtaining the current Market for:
   green, red, yellow, blue

 A. Determine how many generations exist for each locomotive color
    - A generation exists if it has dice (orders) in either existing or customer base

 B. Once generations exist, there are 4 cases:
    i. One generation exists.
       Nothing happens

    ii. Two generations exists.
        A. Starting with lower number generation (older):
        a. Transfer one of the dice (order) from customer base (sales pool) to dice pool (remove it from play)
        b. Roll all remaining dice in sales pool (customer base)
        c. Move all dice from sales pool to orders pool
        d. Mark this locomotive as old

        B. The newer generation is checked.
        a. If it does not have maximum dice (to capacity) then add 1 to the sales pool
             then re-roll all sales pool dice then move all dice back to existing orders

    iii. Three generations exists.
        a. Start with oldest locomotive.
        b. Remove all dice from customer base and existing orders
        c. This locomotive is marked as obsolote
        d. Move to next oldest, add 1 die to customer base if required
        e. Repeat this for the newest locomotive
 */

struct GenerationsExist {
    private var color: Family.Color
    private var locos: [Locomotive]

    init(with locomotives: [Locomotive], find color: Family.Color) {
        self.locos = locomotives
        self.color = color
    }

    func report() -> [Locomotive]? {
        let results = self.marketFor(color: self.color)
        return results
    }

    // A generation only exists if it has dice (orders) in
    // either `existingOrders` or `customerBase` (sales),
    // `initialOrders` should be `rejected`
    private func marketFor(color: Family.Color) -> [Locomotive] {

        // Find all Locomotives that match the type & have orders,
        // sorted by cost & generation ascending

        // compact version
        //let results = locos.filter { !$0.order.isEmpty && $0.order.contains(where: { order in order.state > 0 }) }

        let filter = locos
            .filter { ($0.color == color) &&
                    (!$0.orders.isEmpty) &&
                ($0.orders.contains(where:
                        { order in
                            (
                                (order.state == .existingOrder) ||
                                (order.state == .completedOrder)
                            )
                        })
                )
        }
        .sorted { (a: Locomotive, b: Locomotive) -> Bool in
            return (
                (a.cost < b.cost) &&
                (a.generation.rawValue < b.generation.rawValue)
            )
        }

        /*
         // OLD VERSION
        let filter = locos.filter { (locomotive: Locomotive) -> Bool in
            return (
                (locomotive.color == color) &&
                (locomotive.orders.count > 0)
            )
        }.sorted { (a: Locomotive, b: Locomotive) -> Bool in
            return ((a.cost < b.cost) && (a.generation.rawValue < b.generation.rawValue))
        }
        */

        return filter
    }
}

class MarketDemand {
    private var board: Board

    init(board: Board) {
        self.board = board
    }

    func generationsExist(for color: Family.Color) -> GenerationsExist? {
        guard let board = self.board else {
            return nil
        }
        let genExist = GenerationsExist.init(with: board, find: color)
        return genExist
    }

    func start(with color: Family.Color) {
        let gens = generationsExist(for: color)

        guard let filtered = gens?.report() else {
            return // do nothing
        }

        let howMany = filtered.count

        switch howMany {
        case 1:
            let results = handleOneGeneration(locos: filtered)
            print (results)
        case 2:
            handleTwoGenerations()
        case 3:
            handleThreeGenerations()

        default:
            //print ("do nothing")
            return
        }
    }
}

extension MarketDemand {
    /* -- 1 Generation exists --
     If this locomotive type does not have the maximum number of dice,
     add one die to the Customer Base from the dice pool.
     Then roll all dice in the Customer Base and place them in the empty
     Existing Order boxes for that locomotive type.
     */
    func handleOneGeneration(locos: [Locomotive]) -> [Locomotive] {

        print ("Adding orders...")
        locos.forEach { (locomotive) in
            print ("Locomotive: \(locomotive.name), \(locomotive.color), \(locomotive.orders)")
            let orderBook = OrderBook.init(capacity: locomotive.orderCapacity, orders: locomotive.orders)
            do {
                let _ = try orderBook.add(.completedOrder)
            } catch {
                print ("error -- \(error as Any)")
            }
            guard let orderBookOrders = orderBook.orders else {
                print ("Can't obtain orderbook proxy orders")
                return
            }
            locomotive.orders = orderBookOrders
        }

        return locos
    }
}

extension MarketDemand {
    func handleTwoGenerations() {

    }
}

extension MarketDemand {
    func handleThreeGenerations() {

    }
}
