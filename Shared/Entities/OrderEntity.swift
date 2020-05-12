//
//  OrderEntity.swift
//  EngineYard
//
//  Created by Amarjit on 12/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

// :[Realm entity] Order

class OrderEntity: Object {
    @objc dynamic var uuid: UUID = UUID()
    @objc dynamic var id: Int = 0
    @objc dynamic var value: Int = 0
    @objc dynamic var orderState: Int = 0

    override static func primaryKey() -> String {
       return "id"
    }
}
