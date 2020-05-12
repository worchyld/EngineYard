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
    @objc dynamic var uuid: UUID = UUID()
    @objc dynamic var id: Int = 0
    @objc dynamic var isActivePlayer: Bool = false
    @objc dynamic var turnOrderIndex: Int = 0

    override static func primaryKey() -> String {
       return "id"
    }
}
