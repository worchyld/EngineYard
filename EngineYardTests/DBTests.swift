//
//  DBTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 08/05/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import XCTest
@testable import RealmSwift
@testable import EngineYard



class DBTests: EngineYardTests {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // Use an in-memory Realm identified by the name of the current test.
        // This ensures that each test can't accidentally access or modify the data
        // from other tests or the application itself, and because they're in-memory,
        // there's nothing that needs to be cleaned up.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name

        DBManager.showPath()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        DBManager.clearAll()
    }

    func testSingleEntry() {
        let person = Person(name: "name A", age: 18)

        // 2. Expect all properties of that person are correctly assigned.
        XCTAssert(person.name == "name A")
        XCTAssert(person.age == 18)

    }

   

    func testToManyRelationship() {
        
    }

}
