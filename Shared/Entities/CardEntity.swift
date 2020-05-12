//
//  CardEntity.swift
//  EngineYard
//
//  Created by Amarjit on 12/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

// :[Realm entity] Card

class CardEntity: Object {
    @objc dynamic var uuid: UUID = UUID()
    @objc dynamic var id: Int = 0

    override static func primaryKey() -> String {
       return "id"
    }
}
