//
//  SaleEntity.swift
//  EngineYard
//
//  Created by Amarjit on 07/05/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class SaleEntity : Object {
    let owner = LinkingObjects(fromType: SalesBookEntity.self, property: "sales")

    @objc dynamic var productId : String = ""
    @objc dynamic var units : Int = 0
    @objc dynamic var price : Int = 0
}
