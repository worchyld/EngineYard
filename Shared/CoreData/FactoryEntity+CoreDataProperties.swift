//
//  FactoryEntity+CoreDataProperties.swift
//  EngineYard
//
//  Created by Amarjit on 01/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData


extension FactoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FactoryEntity> {
        return NSFetchRequest<FactoryEntity>(entityName: "FactoryEntity")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var maxDice: Int16
    @NSManaged public var name: String?
    @NSManaged public var trainPool: Int16
    @NSManaged public var cards: NSSet?
    @NSManaged public var game: GameEntity?
    @NSManaged public var locomotive: LocomotiveEntity?
    @NSManaged public var orders: NSSet?

}

// MARK: Generated accessors for cards
extension FactoryEntity {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: CardEntity)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: CardEntity)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

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
