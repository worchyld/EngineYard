//
//  OrderEntity+CoreDataProperties.swift
//  EngineYard
//
//  Created by Amarjit on 02/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData


extension OrderEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderEntity> {
        return NSFetchRequest<OrderEntity>(entityName: "OrderEntity")
    }

    @NSManaged public var value: Int16
    @NSManaged public var orderType: Int16
    @NSManaged public var factory: FactoryEntity?

}
