//
//  CardEntity+CoreDataProperties.swift
//  EngineYard
//
//  Created by Amarjit on 26/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData


extension CardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardEntity> {
        return NSFetchRequest<CardEntity>(entityName: "CardEntity")
    }

    @NSManaged public var spentUnits: Int16
    @NSManaged public var units: Int16
    @NSManaged public var cards: DeckEntity?
    @NSManaged public var owner: PlayerEntity?

}
