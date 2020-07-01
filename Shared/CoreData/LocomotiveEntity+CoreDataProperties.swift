//
//  LocomotiveEntity+CoreDataProperties.swift
//  EngineYard
//
//  Created by Amarjit on 01/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData


extension LocomotiveEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocomotiveEntity> {
        return NSFetchRequest<LocomotiveEntity>(entityName: "LocomotiveEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var livery: Int16
    @NSManaged public var generation: Int16
    @NSManaged public var cost: Int16
    @NSManaged public var rust: Int16
    @NSManaged public var avatar: String?
    @NSManaged public var factory: FactoryEntity?
    @NSManaged public var card: CardEntity?

}
