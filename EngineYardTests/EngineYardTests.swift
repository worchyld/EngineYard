//
//  EngineYardTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest
import CoreData

@testable import EngineYard

class EngineYardTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    public func performTest(closure: () throws -> Void) {
           do {
               try closure()
           } catch {
               XCTFail("Unexpected error thrown: \(error)")
           }
       }

    public func assert<T, E: Error>(_ expression: @autoclosure () throws -> T,
                                     throwsErrorOfType expectedError: E.Type) {
        do {
            _ = try expression()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is E)
        }
    }
}

public class PersistenceManager {
    static var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: PersistenceManager.self)])!
        return managedObjectModel
    }()

    public var inMemoryPersistentContainer: NSPersistentContainer!

    public lazy var inMemoryContext: NSManagedObjectContext = {
        return self.inMemoryPersistentContainer.viewContext
    }()

    func fetch<T: NSManagedObject>(_ type: T.Type, completion: @escaping ([T]?, Error?) -> Void) {
        let request = NSFetchRequest<T>(entityName: String(describing: type))

        do {
            let objects = try inMemoryContext.fetch(request)
            completion(objects, nil)
        } catch {
            print (error)
            completion(nil, error)
        }
    }

    public func flushAll(in context: NSManagedObjectContext) throws {
        try FactoryEntity.flushAll(in: inMemoryContext)
        try OrderEntity.flushAll(in: inMemoryContext)
        try CardEntity.flushAll(in: inMemoryContext)
        try GameEntity.flushAll(in: inMemoryContext)
        try PlayerEntity.flushAll(in: inMemoryContext)
    }

    public func save() {
        let context = self.inMemoryContext
        if context.hasChanges {
            do {
                try context.save()
                print ("Saved successfully")
            }
            catch {
                let nserror = error as NSError
                fatalError("Unresolved error -- \(nserror), \(nserror.userInfo)")
            }
        }
    }


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

