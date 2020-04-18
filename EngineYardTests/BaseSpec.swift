//
//  BaseSpec.swift
//  EngineYardTests
//
//  Created by Amarjit on 17/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Quick
import Nimble
import RealmSwift

class BaseSpec: QuickSpec {
  override func spec() {
    super.spec()

    beforeSuite {
      self.useTestDatabase()
    }

    beforeEach {
      self.clearDatabase()
    }
  }
}

extension BaseSpec {
  func useTestDatabase() {
    Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    print("[REALM]: \(Realm.Configuration.defaultConfiguration.description)")
  }

  func clearDatabase() {
    let realm = try! Realm()
    try! realm.write {
      realm.deleteAll()
    }
  }
}
