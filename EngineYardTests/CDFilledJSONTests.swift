//
//  CDFilledJSONTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 04/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest
import CoreData

@testable import EngineYard

class CDFilledJSONTests: EngineYardTests {

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


    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        try self.flushData()

    }

}
