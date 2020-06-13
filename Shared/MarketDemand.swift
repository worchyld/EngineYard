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

/*
A. Determine how many generations exist for each locomotive color
   - A generation exists if it has dice (orders) in either existing or customer base
*/
class Market {
    private let locos: [Locomotive]

    lazy var currentMarket: [Locomotive]? = {
        return findMarket()
    }()
    lazy var green: [Locomotive]? = {
        return currentMarket?.filter({ $0.color == .green })
    }()
    lazy var blue: [Locomotive]? = {
        return currentMarket?.filter({ $0.color == .blue })
    }()
    lazy var yellow: [Locomotive]? = {
        return currentMarket?.filter({ $0.color == .yellow })
    }()
    lazy var red: [Locomotive]? = {
        return currentMarket?.filter({ $0.color == .red })
    }()


    init(with locomotives: [Locomotive]) {
        self.locos = locomotives
        //self.currentMarket = findMarket()
    }

    func demand(for color: Family.Color) -> [Locomotive]? {
        var filter: [Locomotive]?

        switch color {
        case .green:
            filter = self.green
        case .red:
            filter = self.red
        case .yellow:
            filter = self.yellow
        case .blue:
            filter = self.blue
        }

        return filter
    }


    // Not used but kept for now
    /*
    private func market(for color: Family.Color) -> [Locomotive]? {
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
                (a.color.rawValue < b.color.rawValue) &&
                (a.cost < b.cost) &&
                (a.generation.rawValue < b.generation.rawValue)
            )
        }

        return filter
    }*/

    // : Get the current market of locomotives
    // A generation exists if it has dice (orders) in either
    //   `existingOrder` or `completeOrder`.  `initialOrder` should be ignored
    // ---
    // filtering where: orderState is existingOrders or completeOrders
    //       and orders is not empty
    //      sorted by cost, generation, color raw values ascending
    //
    internal func findMarket() -> [Locomotive] {
        print ("Attemping filter: findMarket()")

        let filter = locos
            .filter {
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
                (a.color.rawValue < b.color.rawValue) &&
                (a.cost < b.cost) &&
                (a.generation.rawValue < b.generation.rawValue)
            )
        }

        print ("Filter found: \(filter.count) results")

        return filter
    }
}


class MarketDemand {
    private var board: Board?
    private var market: Market?

    init(board: Board) {
        guard let board = board else {
            print ("No board exists")
            return
        }
        self.board = board
        self.market = Market.init(with: board)
    }

    internal func getDemand(for color: Family.Color) -> [Locomotive]? {
        guard let market = self.market else {
            print ("No market object exists")
            return nil
        }
        guard let demand = market.demand(for: color) else {
            print ("demand returns nil")
            return nil
        }
        return demand
    }


    func handleGenerations(for color: Family.Color) {
        guard let demand = getDemand(for: color) else {
            print ("Demand returns nil")
            return
        }
        let howMany = demand.count

        // : HANDLE GENERATIONS
        // : There are 4 cases of existing generations;
        // --------------------------------------------
        // (A) No generations exists
        //      - Nothing is done for this type
        //
        // (B) 1 generations exist
        //      - Check capacity, add 1 die to salespool
        //      - Re-roll all dice in sales pool and move back to `existingOrders`
        //
        // (C) 2 generations exist
        //      - Older generation: Remove 1 die
        //      - Older generation: Reroll dice in sales, move back to orders
        //      - Older generation: Mark as `old`
        //      - Newer generation: Where possible; add 1 die to the salespool
        //      - Newer generation: Re-roll all salespool dice and move back to `existingOrders`
        //
        // (D) 3 generations exist
        //      - Oldest generation: Remove all dice from oldest generation
        //      - Oldest generation: Marked as `obsolete`
        //      - Middle generation: Where possible, add 1 die to sales pool
        //      - Middle generation: Re-roll all salespool dice and move back to `existingOrders`
        //      - Newest generation: Repeat the above 2 steps
        //      - Middle/Newest state are unchanged

        switch howMany {
        case 1:
            let results = handleOneGeneration(locos: demand)
            print ("\n\nRESULTS -- \(results)")

        case 2:
            handleTwoGenerations()

        case 3:
            handleThreeGenerations()

        default:
            print ("Do nothing")
        }

    }

    private func howManyGenerationsExist(for market: [Locomotive]) -> Int {
        switch market.count {
        case 1...3:
            return market.count
        default:
            return 0
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
            locomotive.setOrders(orders: orderBookOrders)
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
