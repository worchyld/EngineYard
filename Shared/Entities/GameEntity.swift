//
//  GameEntity.swift
//  EngineYard
//
//  Created by Amarjit on 18/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

// :[Realm entity] Game

//private let uniqueId = "84259842-D756-4E5C-923E-747A79B5EC62"

class GameEntity: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var activePlayer: Int = 0
//    @objc dynamic var turnOrderIndex: Int = 0
//    @objc dynamic var hasSound: Bool = false
//    @objc dynamic var hasMusic: Bool = false

    override static func primaryKey() -> String {
       return "id"
    }
}
