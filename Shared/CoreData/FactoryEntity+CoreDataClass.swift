//
//  FactoryEntity+CoreDataClass.swift
//  EngineYard
//
//  Created by Amarjit on 02/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData

@objc(FactoryEntity)
public class FactoryEntity: NSManagedObject {

    // Count
    class func count(in context: NSManagedObjectContext) -> Int {
        let fetchRequest: NSFetchRequest<FactoryEntity> = FactoryEntity.fetchRequest()

        do {
            let count = try context.count(for: fetchRequest)
            return count
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }

    public static func fetchAllFactories(in context: NSManagedObjectContext) throws -> [FactoryEntity]? {
        do {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FactoryEntity.fetchRequest()

            let results = try context.fetch(fetchRequest)
            return results as? [FactoryEntity]
        }
        catch {
            throw error
        }
    }

    public static func flushAll(in context: NSManagedObjectContext) throws {

        do {
            //let fetchRequest : NSFetchRequest<NSFetchRequestResult> = FactoryEntity.fetchRequest()
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FactoryEntity")
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

    public func delete(in context: NSManagedObjectContext) {
        context.delete(self)
    }
}
