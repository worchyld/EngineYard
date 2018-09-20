//
//  Sale.swift
//  EngineYard
//
//  Created by Amarjit on 20/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class PlayerSale {
    weak var player : Player?
    var sales : [Sale] = [Sale]()

    func add(_ sale: Sale) {
        self.sales.append(sale)
    }
}

struct Sale {
    var units : Int
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
}
