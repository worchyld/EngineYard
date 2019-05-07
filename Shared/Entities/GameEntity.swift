//
//  GameEntity.swift
//  EngineYard
//
//  Created by Amarjit on 07/05/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    @objc dynamic var uuid : String = UUID().uuidString
    @objc dynamic var date = Date(timeIntervalSince1970: 1)
    @objc dynamic var phase : Int = 0

    let board = List<DeckEntity>()
    let players = List<PlayerEntity>()    

    override static func primaryKey() -> String? {
        return "uuid"
    }
}
