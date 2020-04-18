//
//  Person.swift
//  EngineYardTests
//
//  Created by Amarjit on 18/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

/**

class Dog: Object {
    @objc dynamic var name = ""
   @objc  dynamic var owner: Person?
  let owners = LinkingObjects(fromType: Person.self, property: "dogs")
}

class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var address = ""
    @objc dynamic var height = 0.0
  @objc dynamic var id = 0

  override static func primaryKey() -> String? {
      return "id"
  }

  let dogs = List<Dog>()

  convenience init(id: Int, name: String, age: Int) {
    self.init()
    self.id = id
    self.name = name
    self.age = age
  }

  override static func ignoredProperties() -> [String] {
    return ["address", "height"]
  }
}

extension Person {
  func save() {
    let realm = try! Realm()
    try! realm.write {
      realm.add(self)
    }
  }

  class func all() -> Results<Person> {
    let realm = try! Realm()
    return realm.objects(Person.self)
  }

  class func adults() -> Results<Person> {
    let realm = try! Realm()
    return realm.objects(Person.self).filter("age >= 18")
  }

  class func oldestFirst() -> Results<Person> {
    let realm = try! Realm()
    return realm.objects(Person.self).sorted(byKeyPath: "age", ascending: false)
  }

  class func first(number: UInt) -> [Person] {
    let realm = try! Realm()
    let results = realm.objects(Person.self)
    var limitedResults = [Person]()
    for i in 0..<min(Int(number), results.count) {
      limitedResults.append(results[i])
    }
    return limitedResults
  }

  func updateName(name: String, age: Int) {
    let realm = try! Realm()
    try! realm.write {
      self.name = name
      self.age = age
    }
  }

  func updateFrom(person: Person) {
    guard self.id == person.id else { return }
    let realm = try! Realm()
    try! realm.write {
        realm.add(person, update: .modified)
    }
  }

  func delete() {
    let realm = try! Realm()
    try! realm.write {
      realm.delete(self)
    }
  }
}
**/
