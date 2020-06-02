//
//  GameModelEntity.swift
//  EngineYard
//
//  Created by Amarjit on 18/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

// :[Realm entity] Game

class GameModelEntity: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var timestamp: Int64 = Date.currentTimeStamp
    @objc dynamic var activePlayer: Int = 0
    @objc dynamic var name: String = "RealmSaveState"

    override static func primaryKey() -> String {
       return "id"
    }

    // RLMRelationships
    let players = List<PlayerEntity>() // To-many relationship
}
