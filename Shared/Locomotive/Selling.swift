//
//  Selling.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class Selling {

    var decks: [Deck]

    init(decks: [Deck]) {
        self.decks = decks
    }

    func getFiltered() -> [Deck] {
        let filtered = self.decks.filter { (d: Deck) -> Bool in
            return ((d.orderBook.existingOrders.count > 0) &&
                    (d.orderBook.totalExistingOrders > 0) &&
                    (d.owners?.count ?? 0 > 0)
            )
        }
        return filtered
    }

}
