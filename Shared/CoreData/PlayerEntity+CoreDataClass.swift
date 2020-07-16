//
//  PlayerEntity+CoreDataClass.swift
//  EngineYard
//
//  Created by Amarjit on 14/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//
//

import Foundation
import CoreData

@objc(PlayerEntity)
public class PlayerEntity: NSManagedObject {
    public static func flushAll(in context: NSManagedObjectContext) throws {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlayerEntity")
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
