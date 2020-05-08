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
}

extension CardEntity {
    override var debugDescription: String {
        let string = "ID: \(self.id), units: \(self.units), spentUnits: \(self.spentUnits), owner: \(String(describing: self.owner)), parentDeck:\(String(describing: self.parentDeck?.id))"
        return string
    }
}

extension CardEntity {
    // Map the model -> entity
    convenience init(with model: Card) {
        self.init()
        guard let _ = model.parent else {
            assertionFailure("No card parent defined")
            return
        }
        self.units = model.units
        self.spentUnits = model.spentUnits
    }
}


/*
extension CardEntity {
    public static func bulkSave(cards: [Card], deckObj: DeckEntity, completion: @escaping (Bool) -> ()) {
        let objectRef = ThreadSafeReference(to: deckObj)

        DispatchQueue(label: "background").async {
           let realmOnBackgroundThread = try! Realm()
           guard let myObject = realmOnBackgroundThread.resolve(objectRef) else {
                print ("object was deleted")
                return // object was deleted
           }
            for card in cards {
                let cardObj = CardEntity.init(with: card)
                cardObj.parentDeck = myObject
                try! realmOnBackgroundThread.write {
                    realmOnBackgroundThread.add(cardObj)
                }

            }
            realmOnBackgroundThread.refresh()
            completion(true)
        }
    }
}
*/
