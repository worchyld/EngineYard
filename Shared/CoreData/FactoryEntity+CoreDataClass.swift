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
    class func count() -> Int {

        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<FactoryEntity> = FactoryEntity.fetchRequest()

        do {
            let count = try context.count(for: fetchRequest)
            return count
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }

    public static func fetchAllFactories() throws -> [FactoryEntity]? {
        do {
            let context = CoreDataManager.shared.context
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = FactoryEntity.fetchRequest()

            let results = try context.fetch(fetchRequest)
            return results as? [FactoryEntity]
        }
        catch {
            throw error
        }
    }

    public static func flushAll() throws {

        do {
            let fetchRequest : NSFetchRequest<NSFetchRequestResult> = FactoryEntity.fetchRequest()
            let objs = try CoreDataManager.shared.context.fetch(fetchRequest)
            for case let obj as NSManagedObject in objs {
                CoreDataManager.shared.context.delete(obj)
            }
            try CoreDataManager.shared.context.save()
        }
        catch {
            throw error
        }
    }

    public func delete() {
        CoreDataManager.shared.context.delete(self)
    }
}
