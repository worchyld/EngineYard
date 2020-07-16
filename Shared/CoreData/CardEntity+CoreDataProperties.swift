//
//  CardEntity+CoreDataProperties.swift
//  EngineYard
//
//  Created by Amarjit on 14/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData


extension CardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardEntity> {
        return NSFetchRequest<CardEntity>(entityName: "CardEntity")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var cost: Int16
    @NSManaged public var generation: Int16
    @NSManaged public var livery: Int16
    @NSManaged public var name: String?
    @NSManaged public var production: Int16
    @NSManaged public var spentProduction: Int16
    @NSManaged public var factory: FactoryEntity?
    @NSManaged public var owner: PlayerEntity?

}
