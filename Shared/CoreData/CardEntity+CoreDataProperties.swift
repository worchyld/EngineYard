//
//  CardEntity+CoreDataProperties.swift
//  EngineYard
//
//  Created by Amarjit on 01/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData


extension CardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardEntity> {
        return NSFetchRequest<CardEntity>(entityName: "CardEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var production: Int16
    @NSManaged public var spentProduction: Int16
    @NSManaged public var owner: PlayerEntity?
    @NSManaged public var parent: FactoryEntity?
    @NSManaged public var locomotive: LocomotiveEntity?

}
