//
//  SalesBook.swift
//  EngineYard
//
//  Created by Amarjit on 25/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class SalesBook : NSObject, NSCopying {
    weak var owner: Player?
    var sales: [Sale] = [Sale]()
    var totalUnitsSold : Int {
        return self.sales.reduce(0, { $0 + $1.units } )
    }
    var totalDollarValue : Int {
        return self.sales.reduce(0, { $0 + $1.total } )
    }

    override var description: String {
        return ("SalesBook: #items: \(self.sales.count)  #units: \(self.totalUnitsSold), Total $\(self.totalDollarValue)")
    }

    init(owner: Player) {
        super.init()
        self.owner = owner
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = SalesBook(owner: self.owner!)
        return copy
    }

    func add(sale: Sale) {
        self.sales.append(sale)
    }

    func clear() {
        self.sales.removeAll()
    }
}
