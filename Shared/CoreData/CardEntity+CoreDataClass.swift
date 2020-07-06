//
//  CardEntity+CoreDataClass.swift
//  EngineYard
//
//  Created by Amarjit on 02/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CardEntity)
public class CardEntity: NSManagedObject {
    public static func flushAll(in context: NSManagedObjectContext) throws {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CardEntity")
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
}
