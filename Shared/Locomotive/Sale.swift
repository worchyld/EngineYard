//
//  Sale.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// Sales model - Records a product, unit and price
struct Sale {
    var product : Deck?
    var units : Int = 0
    var price : Int = 0

    var total : Int {
        guard (units > 0 && price > 0) else {
            return 0
        }
        return (units * price)
    }

    init(product: Deck? = nil, units: Int, price: Int) {
        if let product = product {
            self.product = product
        }
        self.units = units
        self.price = price
    }
}
