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

extension OrderEntity {
    // Map the model -> entity
    convenience init(model: Order) {
        self.init()
        self.state = model.state.rawValue
        self.value = model.value
    }
}

extension Order {
    // Map the entity -> model
    convenience init(entity: OrderEntity) {
        var state: Order.State

        state = Order.State.init(rawValue: entity.state) ?? Order.State.existingOrder

        let value = entity.value

        self.init(state: state, value: value)
    }
}
