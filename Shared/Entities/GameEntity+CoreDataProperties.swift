//
//  GameEntity+CoreDataProperties.swift
//  EngineYard
//
//  Created by Amarjit on 26/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData


extension GameEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameEntity> {
        return NSFetchRequest<GameEntity>(entityName: "GameEntity")
    }

    @NSManaged public var phase: Int16
    @NSManaged public var playerOnTurn: Int16
    @NSManaged public var state: Int16
    @NSManaged public var decks: NSSet?
    @NSManaged public var players: NSSet?

}

// MARK: Generated accessors for decks
extension GameEntity {

    @objc(addDecksObject:)
    @NSManaged public func addToDecks(_ value: DeckEntity)

    @objc(removeDecksObject:)
    @NSManaged public func removeFromDecks(_ value: DeckEntity)

    @objc(addDecks:)
    @NSManaged public func addToDecks(_ values: NSSet)

    @objc(removeDecks:)
    @NSManaged public func removeFromDecks(_ values: NSSet)

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
