//
//  DeckEntity+CoreDataProperties.swift
//  EngineYard
//
//  Created by Amarjit on 26/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData


extension DeckEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeckEntity> {
        return NSFetchRequest<DeckEntity>(entityName: "DeckEntity")
    }

    @NSManaged public var capacity: Int16
    @NSManaged public var color: Int16
    @NSManaged public var cost: Int16
    @NSManaged public var generation: Int16
    @NSManaged public var income: Int16
    @NSManaged public var name: String?
    @NSManaged public var numberOfChildren: Int16
    @NSManaged public var productionCost: Int16
    @NSManaged public var state: Int16
    @NSManaged public var deck: NSSet?
    @NSManaged public var game: GameEntity?

}

// MARK: Generated accessors for deck
extension DeckEntity {

    @objc(addDeckObject:)
    @NSManaged public func addToDeck(_ value: CardEntity)

    @objc(removeDeckObject:)
    @NSManaged public func removeFromDeck(_ value: CardEntity)

    @objc(addDeck:)
    @NSManaged public func addToDeck(_ values: NSSet)

    @objc(removeDeck:)
    @NSManaged public func removeFromDeck(_ values: NSSet)

}
