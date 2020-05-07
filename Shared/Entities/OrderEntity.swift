//
//  OrderSpec.swift
//  EngineYard
//
//  Created by Amarjit on 18/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

// [REALM] Order entity
class OrderEntity: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var state: Int = 0 // see: Order.state
    @objc dynamic var value: Int = 0

    override static func primaryKey() -> String {
       return "id"
    }

    // RLMRelationships
    @objc dynamic var parentDeck: DeckEntity? // to-one relationship
}
