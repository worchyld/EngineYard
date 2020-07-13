//
//  OrderEntity+CoreDataClass.swift
//  EngineYard
//
//  Created by Amarjit on 02/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData

@objc(OrderEntity)
public class OrderEntity: NSManagedObject {

    public static func flushAll(in context: NSManagedObjectContext) throws {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "OrderEntity")
            let objs = try context.fetch(fetchRequest)
            for case let obj as NSManagedObject in objs {
                context.delete(obj)
            }

            try context.save()
        }
        catch {
            throw error
        }
    }

    class func create(in context: NSManagedObjectContext, value: Int, orderType: OrderType) -> OrderEntity {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "OrderEntity", into: context) as! OrderEntity
        entity.value = Int16(value)
        entity.orderType = Int16(orderType.rawValue)
        return entity
    }
}
