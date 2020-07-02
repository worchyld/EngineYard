//
//  GameEntity+CoreDataProperties.swift
//  EngineYard
//
//  Created by Amarjit on 02/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData


extension GameEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameEntity> {
        return NSFetchRequest<GameEntity>(entityName: "GameEntity")
    }

    @NSManaged public var createdOn: Int32
    @NSManaged public var updatedOn: Int32
    @NSManaged public var notes: String?
    @NSManaged public var phase: Int16
    @NSManaged public var players: NSSet?
    @NSManaged public var factories: NSSet?

}

// MARK: Generated accessors for players
extension GameEntity {

    @objc(addPlayersObject:)
    @NSManaged public func addToPlayers(_ value: PlayerEntity)

    @objc(removePlayersObject:)
    @NSManaged public func removeFromPlayers(_ value: PlayerEntity)

    @objc(addPlayers:)
    @NSManaged public func addToPlayers(_ values: NSSet)

    @objc(removePlayers:)
    @NSManaged public func removeFromPlayers(_ values: NSSet)

}

// MARK: Generated accessors for factories
extension GameEntity {

    @objc(addFactoriesObject:)
    @NSManaged public func addToFactories(_ value: FactoryEntity)

    @objc(removeFactoriesObject:)
    @NSManaged public func removeFromFactories(_ value: FactoryEntity)

    @objc(addFactories:)
    @NSManaged public func addToFactories(_ values: NSSet)

    @objc(removeFactories:)
    @NSManaged public func removeFromFactories(_ values: NSSet)

}
