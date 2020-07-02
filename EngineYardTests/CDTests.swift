//
//  CDTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 01/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest
import CoreData

@testable import EngineYard

class CDTests: EngineYardTests {


    public lazy var mockPersistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EYGame")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )

            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
            if let nserror = error as NSError? {
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        })
        return container
    }()

    override func tearDownWithError() throws {
        try self.flushData()
    }

    func flushData() throws {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FactoryEntity")
        let objs = try self.mockPersistentContainer.viewContext.fetch(fetchRequest)
        for case let obj in objs {
            self.mockPersistentContainer.viewContext.delete(obj)
        }
        do {
            let _ = try self.mockPersistentContainer.viewContext.save()
        }
        catch {
            throw error
        }
    }

    func testFetchFactories() throws {
        let context = self.mockPersistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FactoryEntity")

        do {
           let results = try context.fetch(fetchRequest)
            XCTAssertTrue(results.count == 0)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func testDidCreate() throws {
        let context = self.mockPersistentContainer.viewContext
        let factory = FactoryEntity.init(context: context)
        factory.name = "Green.1"
        factory.livery = Int16(Livery.green.rawValue) as Int16
        factory.generation = Int16(Generation.first.rawValue) as Int16
        factory.rust = Int16(Rust.new.rawValue) as Int16
        factory.avatar = "green-1.png"

        try context.save()


        do {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FactoryEntity")
            let results = try context.fetch(fetchRequest)
            XCTAssertEqual(results.count, 1)

            guard let firstObj = results.first as? FactoryEntity else {
                XCTFail("No object found")
                return
            }

            XCTAssertEqual(firstObj, factory)
        }
        catch {
            throw error
        }
    }

}
