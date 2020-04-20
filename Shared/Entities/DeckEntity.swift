//
//  DeckSpec.swift
//  EngineYard
//
//  Created by Amarjit on 18/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

// [REALM] Deck entity
class DeckEntity : Object {
    @objc dynamic var state: Int = 0
    @objc dynamic var color: Int = 0
    @objc dynamic var generation: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var cost: Int = 0
    @objc dynamic var capacity: Int = 0
    @objc dynamic var numberOfChildren: Int = 0

    // RLMRelationships
    let cards = List<CardEntity>() // To-many relationship
    let orders = List<OrderEntity>() // To-many relationship

    convenience init(with deck: Deck) {
        self.init()
        self.state = deck.state.rawValue
        self.color = deck.color.rawValue
        self.generation = deck.generation.rawValue
        self.name = deck.name
        self.cost = deck.cost
        self.capacity = deck.capacity
        self.numberOfChildren = deck.numberOfChildren
    }
}


extension DeckEntity {
  func save() {
    let realm = try! Realm()
    try! realm.write {
      realm.add(self)
    }
  }

  class func all() -> Results<DeckEntity> {
    let realm = try! Realm()
    return realm.objects(DeckEntity.self)
  }

  func updateFrom(deckEntity: DeckEntity) {
    let realm = try! Realm()
    try! realm.write {
        realm.add(deckEntity, update: .modified)
    }
  }

  func delete() {
    let realm = try! Realm()
    try! realm.write {
      realm.delete(self)
    }
  }
}
