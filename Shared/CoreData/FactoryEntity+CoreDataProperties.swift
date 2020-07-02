//
//  FactoryEntity+CoreDataProperties.swift
//  EngineYard
//
//  Created by Amarjit on 02/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData


extension FactoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FactoryEntity> {
        return NSFetchRequest<FactoryEntity>(entityName: "FactoryEntity")
    }

    @NSManaged public var livery: Int16
    @NSManaged public var generation: Int16
    @NSManaged public var name: String?
    @NSManaged public var cost: Int16
    @NSManaged public var rust: Int16
    @NSManaged public var rustedBy: Int16
    @NSManaged public var avatar: String?
    @NSManaged public var trainPool: Int16
    @NSManaged public var maxDice: Int16
    @NSManaged public var orders: NSSet?
    @NSManaged public var game: GameEntity?
    @NSManaged public var cards: CardEntity?

}

// MARK: Generated accessors for orders
extension FactoryEntity {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: OrderEntity)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: OrderEntity)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}
