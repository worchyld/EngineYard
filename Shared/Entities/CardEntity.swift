//
//  CardEntity.swift
//  EngineYard
//
//  Created by Amarjit on 12/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

// :[Realm entity] Card

class CardEntity: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var units: Int = 0
    @objc dynamic var spentUnits: Int = 0

    override static func primaryKey() -> String {
       return "id"
    }

    // RLMRelationships
    @objc dynamic var owner: PlayerEntity? // To-one relationship
    @objc dynamic var parentDeck: DeckEntity? // To-one relationship
}

extension CardEntity {
    override var debugDescription: String {
        let string = "ID: \(self.id), units: \(self.units), spentUnits: \(self.spentUnits), owner: \(String(describing: self.owner)), parentDeck:\(String(describing: self.parentDeck?.id))"
        return string
    }
}
