//
//  Sale.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// `Sales` model - Records a product, unit and price
struct Sale : CustomStringConvertible {
    var productId : String?
    var units : Int = 0 // units sold
    var price : Int = 0 // price sold at

    var total : Int {
        guard (units > 0 && price > 0) else {
            return 0
        }
        return (units * price)
    }

    init(productId: String? = nil, units: Int, price: Int) {
        if let productId = productId {
            self.productId = productId
        }
        self.units = units
        self.price = price
    }

    var description: String {
        return ("Sale:: \(self.units) units sold at $\(self.price) for a total of \(self.total)")
    }
}
