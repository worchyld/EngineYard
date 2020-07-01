//
//  PlayerEntity+CoreDataProperties.swift
//  EngineYard
//
//  Created by Amarjit on 01/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData


extension PlayerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerEntity> {
        return NSFetchRequest<PlayerEntity>(entityName: "PlayerEntity")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var cash: Int16
    @NSManaged public var name: String?
    @NSManaged public var state: Int16
    @NSManaged public var turnOrder: Int16
    @NSManaged public var cards: NSSet?
    @NSManaged public var game: GameEntity?

}

// MARK: Generated accessors for cards
extension PlayerEntity {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: CardEntity)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: CardEntity)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}
