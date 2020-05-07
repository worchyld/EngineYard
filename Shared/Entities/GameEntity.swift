//
//  GameEntity.swift
//  EngineYard
//
//  Created by Amarjit on 18/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var activePlayer: Int = 0
    @objc dynamic var gamePhase: Int = 0
    @objc dynamic var page: String = ""
    @objc dynamic var hasSound: Bool = false
    @objc dynamic var hasMusic: Bool = false

    override static func primaryKey() -> String {
       return "id"
    }
}
