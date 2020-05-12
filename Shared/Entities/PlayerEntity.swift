//
//  PlayerEntity.swift
//  EngineYard
//
//  Created by Amarjit on 12/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

// :[Realm entity] Player

//private let uniqueId = "84259842-D756-4E5C-923E-747A79B5EC62"

class PlayerEntity: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var playerId: Int = 0

    @objc dynamic var name: String = ""
    @objc dynamic var isAI: Bool = false
    @objc dynamic var cash: Int = 0
    @objc dynamic var avatar: String = ""
    @objc dynamic var turnOrderIndex: Int = 0
    @objc dynamic var isActivePlayer: Bool = false
    @objc dynamic var state: Int = 0 // active, waiting, thinking, etc

    override static func primaryKey() -> String {
       return "id"
    }

    // RLMRelationships
    let cards = List<CardEntity>() // To-many relationship
}
