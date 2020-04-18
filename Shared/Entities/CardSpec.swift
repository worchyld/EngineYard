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
class CardSpec: Object {
    @objc dynamic var units: Int = 0
    @objc dynamic var spentUnits: Int = 0

    // RLMRelationships
    @objc dynamic var owner: PlayerSpec? // To-one relationship
    @objc dynamic var parentDeck: DeckSpec? // To-one relationship
}
