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

private let inMemoryIdentifier: String = "Yard"

class BaseSpec: QuickSpec {
    override func spec() {
        super.spec()

        beforeSuite {
            self.useTestDatabase()
        }

        beforeEach {
            self.clearDatabase()
        }

        describe("Realm Config Setup") {
            it("Config setup correctly") {
                let config = Realm.Configuration.defaultConfiguration
                expect(config.inMemoryIdentifier) == inMemoryIdentifier
            }
        }
    }
}

extension BaseSpec {
    func useTestDatabase() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = inMemoryIdentifier
        print("[REALM]: \(Realm.Configuration.defaultConfiguration.description)")
    }

    func clearDatabase() {
        do {
            let realm = try Realm()

            do {
                let _ = try realm.write {
                    realm.deleteAll()
                }
            } catch let error as NSError {
                fail(error.description)
                return
            }

        } catch let error as NSError {
            fail(error.description)
            return
        }
    }
}
