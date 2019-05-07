//
//  SalesBookEntity.swift
//  EngineYard
//
//  Created by Amarjit on 07/05/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class SalesBookEntity: Object {
    @objc dynamic var name : String = ""

    let owner = LinkingObjects(fromType: PlayerEntity.self, property: "salesBook")
    let sales = List<SaleEntity>()
    
}

