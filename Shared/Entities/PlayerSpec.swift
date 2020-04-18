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
class PlayerSpec: Object {
    @objc dynamic var playerId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var isAI: Bool
    @objc dynamic var cash: Int = 0
    @objc dynamic var avatar: String
    @objc dynamic var turnOrder: Int = 0

    // RLMRelationships
    let cards = List<CardSpec>() // To-many relationship
}
