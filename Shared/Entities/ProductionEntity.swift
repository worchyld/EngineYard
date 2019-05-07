//
//  ProductionEntity.swift
//  EngineYard
//
//  Created by Amarjit on 07/05/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class ProductionEntity: Object {
    @objc dynamic var units : Int = 0
    @objc dynamic var spentUnits : Int = 0

    let parent = LinkingObjects(fromType: CardEntity.self, property: "production")
}

