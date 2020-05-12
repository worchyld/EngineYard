//
//  DeckEntity.swift
//  EngineYard
//
//  Created by Amarjit on 12/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

// :[Realm entity] Deck

class DeckEntity : Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var state: Int = 0
    @objc dynamic var color: Int = 0
    @objc dynamic var generation: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var cost: Int = 0
    @objc dynamic var capacity: Int = 0
    @objc dynamic var numberOfChildren: Int = 0

    override static func primaryKey() -> String {
       return "id"
    }

    // RLMRelationships
    let cards = List<CardEntity>() // To-many relationship
    let orders = List<OrderEntity>() // To-many relationship
}

extension DeckEntity {
    override var debugDescription: String {
        let string = "ID: \(self.id), name: \(self.name), cost: \(self.cost), generation:\(self.generation), color: \(self.color), capacity: \(self.capacity), numberOfChildren: \(self.numberOfChildren), #cards: \(self.cards.count)"
        return string
    }
}
