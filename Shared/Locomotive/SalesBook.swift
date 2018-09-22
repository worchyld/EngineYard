//
//  SalesBook.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class SalesBook {
    var owner : Player?
    var sales : [Sale] = [Sale]()
    var total : Int {
        return self.sales.reduce(0, { $0 + $1.price })
    }
}
