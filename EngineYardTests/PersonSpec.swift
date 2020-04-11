//
//  PersonSpec.swift
//  EngineYardTests
//
//  Created by Amarjit on 11/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest
import Quick
import Nimble
import RealmSwift

@testable import EngineYard

class Person: Object {
  dynamic var name = ""
  dynamic var age = 0

  convenience init(name: String, age: Int) {
    self.init()
    self.name = name
    self.age = age
  }
}

class PersonSpec: QuickSpec {
  override func spec() {
    super.spec()

    beforeSuite {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        print("[REALM]: \(Realm.Configuration.defaultConfiguration.fileURL!)")
        print("[REALM]: \(Realm.Configuration.defaultConfiguration.description)")
    }

    beforeEach {
      let realm = try! Realm()
      try! realm.write {
        realm.deleteAll()
      }
    }

    describe("initialize with name and age") {
      it("initializes and assign properties correctly") {
        // 1. Create a person using the custom initializer
        let person = Person(name: "name A", age: 18)

        // 2. Expect all properties of that person are correctly assigned.
        expect(person.name) == "name A"
        expect(person.age) == 18
      }
    }
  }
}
