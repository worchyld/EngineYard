//
//  PlayerEntity.swift
//  EngineYard
//
//  Created by Amarjit on 07/05/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class PlayerEntity: Object {
    @objc dynamic var uuid : String = UUID().uuidString
    @objc dynamic var name : String = ""
    @objc dynamic var cash : Int = 0
    @objc dynamic var turnOrder : Int = 0
    @objc dynamic var asset : String = ""
    @objc dynamic var isAI : Bool = true

    let hand = List<CardEntity>()
    let salesBook = List<SalesBookEntity>()

    override static func primaryKey() -> String? {
        return "uuid"
    }
}
