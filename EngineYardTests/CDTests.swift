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

class PersistenceManager {
    static var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: PersistenceManager.self)])!
        return managedObjectModel
    }()

    public var inMemoryPersistentContainer: NSPersistentContainer!

    public lazy var inMemoryContext: NSManagedObjectContext = {
        return self.inMemoryPersistentContainer.viewContext
    }()


    init() {
        // setup in-memory NSPersistentContainer
        let storeURL = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent("store")
        let description = NSPersistentStoreDescription(url: storeURL)
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        description.shouldAddStoreAsynchronously = false
        description.type = NSInMemoryStoreType

        let persistentContainer = NSPersistentContainer(name: "EYGame", managedObjectModel: PersistenceManager.managedObjectModel)
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Fail to create CoreData Stack \(error.localizedDescription)")
            } else {
                print("CoreData Stack set up with in-memory store type")
            }
        }

        self.inMemoryPersistentContainer = persistentContainer
    }
}


class CDTests: EngineYardTests {

    private var persistenceManager = PersistenceManager()
    private lazy var inMemoryPersistentContainer: NSPersistentContainer = {
        self.persistenceManager.inMemoryPersistentContainer
    }()
    private lazy var inMemoryContext: NSManagedObjectContext = {
        self.persistenceManager.inMemoryContext
    }()

    override func setUp() {
        self.persistenceManager = PersistenceManager()
    }

    override func tearDownWithError() throws {
        try self.flushData()
    }

    func flushData() throws {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FactoryEntity")
        let objs = try self.inMemoryContext.fetch(fetchRequest)
        for case let obj in objs {
            self.inMemoryPersistentContainer.viewContext.delete(obj)
        }
        do {
            let _ = try self.inMemoryPersistentContainer.viewContext.save()
        }
        catch {
            throw error
        }
    }

    func testFetchFactories() throws {
        let context = self.inMemoryContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FactoryEntity")

        do {
           let results = try context.fetch(fetchRequest)
            XCTAssertTrue(results.count == 0)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }



    func testDidCreate() throws {
        let context = self.inMemoryContext

        let factory: FactoryEntity = NSEntityDescription.insertNewObject(forEntityName: "FactoryEntity" , into: context) as! FactoryEntity
        factory.name = "Green.1"
        factory.livery = Int16(Livery.green.rawValue) as Int16
        factory.generation = Int16(Generation.first.rawValue) as Int16
        factory.rust = Int16(Rust.new.rawValue) as Int16
        factory.avatar = "green-1.png"

        try context.save()



        do {
            let fetchRequest: NSFetchRequest<FactoryEntity> = FactoryEntity.fetchRequest()

            //NSFetchRequest<NSManagedObject>(entityName: "FactoryEntity")
            let results = try context.fetch(fetchRequest)
            XCTAssertEqual(results.count, 1)

            print ("Results Found -- \(results.count)")

            guard let firstObj = results.first else {
                XCTFail("No object found")
                return
            }

            XCTAssertEqual(firstObj, factory)
        }
        catch {
            throw error
        }
    }


    func testDidCreateAndDelete() throws {
       let context = self.inMemoryContext

        let factory: FactoryEntity = NSEntityDescription.insertNewObject(forEntityName: "FactoryEntity" , into: context) as! FactoryEntity
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

            context.delete(firstObj)
            try context.save()

            let results2 = try context.fetch(fetchRequest)
            XCTAssertEqual(results2.count, 0)

        }
        catch {
            throw error
        }
    }


    func testDidCreateAndEdit() throws {
        let context = self.inMemoryContext

        let factory: FactoryEntity = NSEntityDescription.insertNewObject(forEntityName: "FactoryEntity" , into: context) as! FactoryEntity
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

            firstObj.cost = 14

            try context.save()


            let results2 = try context.fetch(fetchRequest)
            XCTAssertEqual(results2.count, 1)

            guard let firstObj2 = results2.first as? FactoryEntity else {
                XCTFail("No object found")
                return
            }

            XCTAssertEqual(firstObj2.cost, 14)

            print ("firstobj = \(firstObj2 as Any)")
        }
        catch {
            throw error
        }
    }

    func testCDFactoryHasOrders() throws {
        let context = self.inMemoryContext

        let factory: FactoryEntity = NSEntityDescription.insertNewObject(forEntityName: "FactoryEntity" , into: context) as! FactoryEntity
        factory.name = "Green.1"
        factory.livery = Int16(Livery.green.rawValue) as Int16
        factory.generation = Int16(Generation.first.rawValue) as Int16
        factory.rust = Int16(Rust.new.rawValue) as Int16
        factory.avatar = "green-1.png"

        try context.save()

        for _ in 1...3 {
            let o: OrderEntity = NSEntityDescription.insertNewObject(forEntityName: "OrderEntity", into: context) as! OrderEntity
            o.value = Int16(Die.roll)
            o.orderType = Int16(OrderType.existingOrder.rawValue)
            factory.addToOrders(o)
        }
       try context.save()

        let fetchRequest: NSFetchRequest<FactoryEntity> = FactoryEntity.fetchRequest()
        let results: [FactoryEntity] = try context.fetch(fetchRequest) as [FactoryEntity]

        guard let firstObj = results.first else {
            XCTFail("No first obj")
            return
        }
        XCTAssertNotNil( firstObj.orders )
        XCTAssertEqual( firstObj.orders?.count , 3)

        print (firstObj)

    }
}
