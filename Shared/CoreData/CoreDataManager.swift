//
//  CDPersistence.swift
//  EngineYard
//
//  Created by Amarjit on 01/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import CoreData


class CoreDataManager: NSObject {

    static let shared = CoreDataManager()   // Singleton

    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "EYGame")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let nserror = error as NSError? {
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        })
        return container
    }()

    public var context: NSManagedObjectContext {

        get {
            return self.persistentContainer.viewContext
        }
    }

    // MARK: - Core Data Saving support

    public func save() {

        if self.context.hasChanges {
            do {
                try self.context.save()
                print("In CoreData.stack.save()")
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


    // MARK: - Managed Object Helpers

    class func executeBlockAndCommit(_ block: @escaping () -> Void) {

        block()
        CoreDataManager.shared.save()
    }

}
