//
//  OrderBook.swift
//  EngineYard
//
//  Created by Amarjit on 07/05/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class OrderBookEntity: Object {
    let parent = LinkingObjects(fromType: DeckEntity.self, property: "orderBook")
    let orders = List<OrderBookEntity>()
}

