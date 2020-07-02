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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = LocomotiveEntity.fetchRequest()


        // Batch delete with merge changes
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        let result = try context.execute(batchDeleteRequest) as! NSBatchDeleteResult
        let changes: [AnyHashable: Any] = [
            NSDeletedObjectsKey: result.result as! [NSManagedObjectID]
        ]
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [context])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.

    }

    func testDidCreate() throws {
        let context = CoreDataManager.shared.context
        let locomotive = LocomotiveEntity.init(context: context)
        locomotive.name = "Green.1"
        locomotive.livery = Int16(Livery.green.rawValue) as Int16
        locomotive.generation = Int16(Generation.first.rawValue) as Int16
        locomotive.rust = Int16(Rust.new.rawValue) as Int16
        locomotive.avatar = "green-1.png"

        try context.save()

        let request: NSFetchRequest = LocomotiveEntity.fetchRequest()

        do {
            let objects = try context.fetch( request )
            XCTAssertEqual(objects.count, 1)
            guard let firstObject = objects.first else {
                XCTFail("No first object found")
                return
            }
            XCTAssertEqual(firstObject, locomotive)
        }
        catch {
            XCTFail(error.localizedDescription)
        }

    }

    func testDidEdit() {

    }

    func testDidDelete() {

    }

    func testHasRelationships() {

    }

    func testOrderTypes() {

    }
}
