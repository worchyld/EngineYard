//
//  PlayerSpec.swift
//  EngineYard
//
//  Created by Amarjit on 18/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

// [REALM] Player entity
class PlayerEntity: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var playerId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var isAI: Bool = false
    @objc dynamic var cash: Int = 0
    @objc dynamic var avatar: String = ""
    @objc dynamic var turnOrder: Int = 0

    override static func primaryKey() -> String {
       return "id"
    }

    // RLMRelationships
    let cards = List<CardEntity>() // To-many relationship
}
