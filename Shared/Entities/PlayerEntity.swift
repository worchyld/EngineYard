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

extension PlayerEntity {
    // Map model -> entity
    convenience init(model: Player) {
        self.init()

        self.playerId = model.playerId
        self.name = model.name
        self.isAI = model.isAI
        self.cash = model.cash
        self.avatar = model.avatar
        self.turnOrder = model.turnOrder
    }
}

extension Player {
    // Map entity -> model
    convenience init(entity: PlayerEntity) {
        let playerId = entity.playerId
        let name = entity.name
        let isAI = entity.isAI
        //let cash = entity.cash
        //let avatar = entity.avatar
        //let turnOrder = entity.turnOrder

        self.init(id: playerId, name: name, isAI: isAI)
    }
}
