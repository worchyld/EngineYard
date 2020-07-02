//
//  PlayerEntity+CoreDataProperties.swift
//  EngineYard
//
//  Created by Amarjit on 02/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData


extension PlayerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerEntity> {
        return NSFetchRequest<PlayerEntity>(entityName: "PlayerEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var avatar: String?
    @NSManaged public var cash: Int16
    @NSManaged public var turnOrder: Int16
    @NSManaged public var state: Int16
    @NSManaged public var cards: CardEntity?
    @NSManaged public var game: GameEntity?

}
