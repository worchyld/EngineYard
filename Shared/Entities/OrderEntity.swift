//
//  OrderEntity.swift
//  EngineYard
//
//  Created by Amarjit on 07/05/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class OrderEntity: Object {
    let owner = LinkingObjects(fromType: PlayerEntity.self, property: "order")

    @objc dynamic var orderType : Int = 0
    @objc dynamic var value : Int = 0
}
