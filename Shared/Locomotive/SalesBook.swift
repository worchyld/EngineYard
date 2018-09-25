//
//  SalesBook.swift
//  EngineYard
//
//  Created by Amarjit on 25/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class SalesBook : NSObject {
    weak var parent : Deck?
    var sales: [Sale] = [Sale]()
    var total : Int {
        return self.sales.reduce(0, { $0 + $1.total } )
    }

    override var description: String {
        return ("SalesLedger: Items Sold: \(self.sales.count), Total $:\(self.total)")
    }

    init(parent: Deck) {
        self.parent = parent
        super.init()
    }

    func add(sale: Sale) {
        self.sales.append(sale)
    }
}
