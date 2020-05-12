//
//  GameLogEntity.swift
//  EngineYard
//
//  Created by Amarjit on 12/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class GameLogEntity: Object {
    @objc dynamic var uuid: UUID = UUID()
    @objc dynamic var date: Date = Date(timeIntervalSinceNow: 0)
    @objc dynamic var id: Int = 0
    @objc dynamic var text: String = ""

    override static func primaryKey() -> String {
       return "id"
    }
}
