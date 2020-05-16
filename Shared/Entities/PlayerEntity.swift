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

class PlayerEntity: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var playerId: Int = 0
    @objc dynamic var state: Int = 0 // active, waiting, thinking, etc

    override static func primaryKey() -> String {
       return "id"
    }

    // RLMRelationships
    //let cards = List<CardEntity>() // To-many relationship
    @objc dynamic var game: GameEntity? // To-one relationship
}
