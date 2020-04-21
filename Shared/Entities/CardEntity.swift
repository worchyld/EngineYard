//
//  CardSpec.swift
//  EngineYard
//
//  Created by Amarjit on 18/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

// [REALM] Card entity
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

    convenience init(with card: Card) {
        guard let parent = card.parent else { return }
        self.init()
        self.units = card.units
        self.spentUnits = card.spentUnits
        self.parentDeck = DeckEntity.find(parent: parent)
    }
}
