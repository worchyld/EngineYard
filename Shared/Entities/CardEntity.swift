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
        self.init()
        guard let _ = card.parent else { return }
        self.units = card.units
        self.spentUnits = card.spentUnits
    }
}

/**
extension CardEntity {
    func save() {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                // Get realm and table instances for this thread
                let realm = try! Realm()

                realm.add(self)

                // Commit the write
                try! realm.commitWrite()
            }
        }
    }
}
**/
