//
//  SalesOrder.swift
//  EngineYard
//
//  Created by Amarjit on 23/04/2023.
//

import Foundation

struct SalesOrder {
    private var _orders: [Int]
    var orders: [Int] {
        return _orders
    }

    init(orders: [Int]) {
        _orders = orders
    }

    func match(_ good: Int) -> (Int, Int)? {
        var match = _orders.enumerated().filter {
            good == $0.element
        }

        match = match.flatMap {
            [($0.offset, $0.element)]
        }
        return match.first
    }

    func lower(_ good: Int) -> (Int, Int)? {
        let lower = _orders.enumerated().max {
            a, b in
            return a.element > b.element
        }

        let upper = _orders.enumerated().max {
            a, b in
            return a.element < b.element
        }

        guard let lowerValue = lower?.1, let upperValue = upper?.1 else {
            return nil
        }

        let range = Range(uncheckedBounds: (lowerValue, upperValue))
        let inRange = range.contains(good)

        if inRange || good < range.lowerBound {
            return upper
        } else {
            return nil
        }
    }

    func higher(_ good: Int) -> (Int, Int)? {
        let upper = _orders.enumerated().max {
            a, b in
            return a.element < b.element
        }

        guard let upperValue = upper?.element else {
            return nil
        }

        if good > upperValue {
            return upper
        } else {
            return nil
        }
    }
}
