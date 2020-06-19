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

enum MarketDemandError : Error, Equatable {
    case noDemandFound
    case noLocomotiveFound
}

class Market {
    private let locos: [Locomotive]

    lazy var demand: [Locomotive]? = {
        return getCurrentMarket()
    }()
    lazy var green: [Locomotive]? = {
        return demand?.filter({ $0.color == .green })
    }()
    lazy var blue: [Locomotive]? = {
        return demand?.filter({ $0.color == .blue })
    }()
    lazy var yellow: [Locomotive]? = {
        return demand?.filter({ $0.color == .yellow })
    }()
    lazy var red: [Locomotive]? = {
        return demand?.filter({ $0.color == .red })
    }()


    init(with locomotives: [Locomotive]) {
        self.locos = locomotives
    }

    func demand(for color: Locomotive.Color) -> [Locomotive]? {
        switch color {
        case .green:
            return self.green
        case .red:
            return self.red
        case .yellow:
            return self.yellow
        case .blue:
            return self.blue
        }
    }

    // : Get the current market of locomotives
    // A generation exists if it has dice (orders) in either
    //   `existingOrder` or `completeOrder`.  `initialOrder` should be ignored
    // ---
    // filtering where: orderState is existingOrders or completeOrders
    //       and orders is not empty
    //      sorted by cost, generation, color raw values ascending
    //
    internal func getCurrentMarket() -> [Locomotive] {
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
    lazy var demand: [Locomotive]? = {
        return self.market?.demand
    }()

    init(board: Board) {
        guard let board = board else {
            print ("No board exists")
            return
        }
        self.board = board
        self.market = Market.init(with: board)
    }

    internal func getDemand(for color: Locomotive.Color) -> [Locomotive]? {
        guard let market = self.market else {
            return nil
        }
        guard let demand = market.demand(for: color) else {
            print ("demand returns nil")
            return nil
        }
        return demand
    }


    func handleGenerations(for locos:[Locomotive]) throws {
        guard let demand = self.demand else {
            throw MarketDemandError.noDemandFound
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

        do {
            switch howMany {
            case 1:
                try handleOneGeneration(locos: locos)

            case 2:
                try handleTwoGenerations(locos: locos)

            case 3:
                try handleThreeGenerations(locos: locos)

            default:
                print ("Do nothing for this type")
                break
            }
        } catch {
            throw error
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
    func handleOneGeneration(locos: [Locomotive]) throws {
        if (locos.count == 1) {
            do {
                try locos.forEach { (locomotive) in
                    if (!locomotive.isFull) {
                        let book = OrderBook.init(with: locomotive)
                        try book.add(.completedOrder)
                        try book.rerollCompletedOrders()
                        try book.transferCompletedOrdersToExisting()
                        book.updateOrders()
                    }
                }
            } catch {
                throw error
            }
        }
    }
}

// (C) 2 generations exist
//      - Older generation: Remove 1 die from salesPool
//      -> If no dice in salesPool, remove 1 die from ordersPool
//
//      - Older generation: Reroll dice in sales, move back to orders
//      - Older generation: Mark as `old`
//      - Newer generation: Where possible; add 1 die to the salespool
//      - Newer generation: Re-roll all salespool dice and move back to `existingOrders`
//
extension MarketDemand {
    func handleTwoGenerations(locos: [Locomotive]) throws {
        let locos = locos.sorted(by: { (a: Locomotive, b: Locomotive) -> Bool in
            return ((a.cost < b.cost) && (a.generation.rawValue < b.generation.rawValue))
        })

        if (locos.count == 2) {
            do {
                // Start with oldest:
                // a. Prune 1 order
                // b. Re-roll dice in completedOrders
                // c. Move dice back to existingOrders
                // d. Mark as `old`

                guard let oldestLoco = locos.first else {
                    throw MarketDemandError.noLocomotiveFound
                }
                guard let newerLoco = locos.last else {
                    throw MarketDemandError.noLocomotiveFound
                }

                let book1 = OrderBook.init(with: oldestLoco)
                book1.pruneSingleOrder()  // a
                try book1.rerollCompletedOrders() // b
                try book1.transferCompletedOrdersToExisting() // c
                oldestLoco.setState(state: .old) // d
                book1.updateOrders()

                // with newer locomotive:
                // a. Check if at capacity
                // b. If not: add 1 die to completedOrders
                // c. Re-roll all dice in completedOrders
                // d. Transfer all orders back to existingOrders

                let book2 = OrderBook.init(with: newerLoco)
                try book2.add(.completedOrder) // a & b
                try book2.rerollCompletedOrders() // c
                try book2.transferCompletedOrdersToExisting() // d
                book2.updateOrders()

            }
            catch {
                throw error
            }
        }
    }
}

extension MarketDemand {
    /*
    iii. Three generations exists.
        a. Start with oldest locomotive.
        b. Remove all dice from customer base and existing orders
        c. This locomotive is marked as obsolote
        d. Move to next oldest, add 1 die to customer base if required
        e. Repeat this for the newest locomotive
     */
    func handleThreeGenerations(locos: [Locomotive]) throws {
        let locos = locos.sorted(by: { (a: Locomotive, b: Locomotive) -> Bool in
            return ((a.cost < b.cost) && (a.generation.rawValue < b.generation.rawValue))
        })

        if (locos.count == 3) {
            do {
                guard let firstLoco = locos.first else {
                    throw MarketDemandError.noLocomotiveFound
                }
                guard let middleLoco = locos[safe: 1] else {
                    throw MarketDemandError.noLocomotiveFound
                }
                guard let youngestLoco = locos.last else {
                    throw MarketDemandError.noLocomotiveFound
                }

                // Start with oldest generation
                // a. Remove all orders regardless of what they are
                // b. Mark as obsolote, demand is nil
                let book1 = OrderBook.init(with: firstLoco)
                book1.removeAll()
                book1.updateOrders()
                firstLoco.setState(state: .obsolete)

                // Middle generation
                // a. Add 1 die to completedOrders (if possible)
                // b. Re-roll all completedOrders
                // c. Move all completedOrders -> existingOrders
                let book2 = OrderBook.init(with: middleLoco)
                try book2.add(.completedOrder)
                try book2.rerollCompletedOrders()
                try book2.transferCompletedOrdersToExisting()
                book2.updateOrders()

                // Youngest generation
                // a. Add 1 die to completedOrders (if possible)
                // b. Re-roll all completedOrders
                // c. Move all completedOrders -> existingOrders
                let book3 = OrderBook.init(with: youngestLoco)
                try book3.add(.completedOrder)
                try book3.rerollCompletedOrders()
                try book3.transferCompletedOrdersToExisting()
                book3.updateOrders()
            }
            catch {
                throw error
            }
        }
    }
}
