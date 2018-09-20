//
//  SalesCaseHandler.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

enum SalesCaseType: Int {
    case perfectMatch
    case higherMatch
    case lowerMatch
}

struct Sale {
    var units : Int // unitsSold
    var price : Int
    var income : Int {
        guard units > 0 else {
            return 0
        }
        guard price > 0 else {
            return 0
        }
        return (units * price)
    }

    init(units: Int, price: Int) {
        self.units = units
        self.price = price
    }
}

class SalesBook : CustomStringConvertible {
    weak var player: Player?
    var sales: [Sale] = [Sale]()

    func add(sale: Sale) {
        self.sales.append(sale)
    }

    var description: String {
        return "SalesBook: \(self.sales)"
    }
}

protocol SalesBookProtocol {
    func add(sale: Sale)
}

class SalesCaseHandler : SalesBookProtocol {
    var salesBook : SalesBook = SalesBook()
    public private (set) var units: Int
    public private (set) var orders: [Int]
    public private (set) var ruleMatched: SalesCaseType?
    var delegate: SalesBookProtocol!

    init(_ units: Int, _ orders: [Int]) {
        self.units = units
        self.orders = orders
        self.delegate = self
    }

    func analyse() {
        let rule = SalesRule.init(orders)

        if let match = rule.perfectMatch(units) {
            print("Found perfect match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
            self.handlePerfectMatch(tuple: match)
        }
        else {
            if let match = rule.lowerMatch(units) {
                print("Found lower match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
                self.handleLowerMatch(tuple: match)
            }
            else {
                if let match = rule.higherMatch(units) {
                    print("Found higher match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")
                    self.handleHigherMatch(tuple: match)
                }
            }
        }
    }

    func salesLoop() {
        var condition = false

        while (units != 0 && (condition == false)) {
            if (condition == false) {
                self.analyse()

                let summarised = orders.reduce(0, +)

                if (summarised == 0) {
                    condition = true
                }
            }
            print ("units: \(units)")
            print ("orders: \(orders)")
            print ("condition: \(condition)")
        }
    }

    // MARK: (Private) functions

    /*
     The player sells all the produced units and moves that die from the Existing Orders box to
     a Customer Base box for that type of locomotive. Then, he places the Production Unit
     counters above the locomotive card in question.
     */
    private func handlePerfectMatch(tuple: (Int, Int)) {
        self.ruleMatched = SalesCaseType.perfectMatch
        let unitsSold = self.orders[tuple.0]
        self.orders[tuple.0] -= unitsSold
        self.units -= unitsSold

        delegate.add(sale: Sale(units: unitsSold, price: 1))
    }

    private func handleLowerMatch(tuple: (Int, Int)) {
        self.ruleMatched = SalesCaseType.lowerMatch
        let unitsSold = self.units
        self.orders[tuple.0] -= unitsSold
        self.units -= unitsSold

        delegate.add(sale: Sale(units: unitsSold, price: 1))
    }

    /* The player sells a number of produced units equal to the highest die */
    private func handleHigherMatch(tuple: (Int, Int)) {
        self.ruleMatched = SalesCaseType.higherMatch
        let unitsSold: Int = {
            return orders[tuple.0] as Int
        }()
        let orderValue: Int = orders[tuple.0] as Int
        var remainingUnits: Int = orderValue
        remainingUnits -= unitsSold
        self.orders[tuple.0] -= unitsSold
        self.units -= unitsSold

        delegate.add(sale: Sale(units: unitsSold, price: 1))
    }
}

extension SalesCaseHandler : CustomStringConvertible {
    var description: String {
        return ("SalesCaseHandler: units: \(self.units), orders: \(self.orders)")
    }
}

extension SalesCaseHandler {
    func add(sale: Sale) {
        self.salesBook.add(sale: sale)
    }
}
