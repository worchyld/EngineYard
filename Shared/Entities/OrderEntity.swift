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
    @objc dynamic var state: Int = 0
    @objc dynamic var value: Int = 0

    // RLMRelationships
    @objc dynamic var parentDeck: DeckEntity? // to-one relationship
}
