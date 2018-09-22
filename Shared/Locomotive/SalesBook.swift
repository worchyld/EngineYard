//
//  SalesBook.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

protocol SalesBookDelegate {
    func add(sale: Sale)
}

class SalesBook : SalesBookDelegate{
    var owner : Player?
    var sales: [Sale] = [Sale]()
    var total : Int {
        return self.sales.reduce(0, { $0 + ($1.price * $1.units) } )
    }

    init(owner: Player? = nil) {
        if let owner = owner {
            self.owner = owner
        }
    }

    deinit {
        self.removeAll()
    }

    func add(sale: Sale) {
        self.sales.append(sale)
    }

    func removeAll() {
        self.sales.removeAll()
    }
}

extension SalesBook : CustomStringConvertible {
    var description: String {
        return ("SalesBook: \(owner?.description ?? "No owner"), \(self.total)")
    }
}
