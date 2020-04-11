//
//  EYRealmTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 11/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest
import RealmSwift
import Quick
import Nimble

@testable import EngineYard


class EYRealmTests: EngineYardTests {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.


        // Use an in-memory Realm identified by the name of the current test.
        // This ensures that each test can't accidentally access or modify the data
        // from other tests or the application itself, and because they're in-memory,
        // there's nothing that needs to be cleaned up.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "Database A"

        print (Realm.Configuration.defaultConfiguration.fileURL ?? "[Realm] not defined")
    }


    func testRealmCreate() {
        
    }


}
