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

/**
class PersonSpec: BaseSpec {
  override func spec() {
    super.spec()

    let personID = 0
    let personName = "Alex"
    let personAge = 18

    describe("models") {
      describe("initialize with name and age") {
        it("initializes correctly") {
          let person = Person(id: personID, name: personName, age: personAge)
          expect(person.name) == personName
          expect(person.age) == personAge
        }
      }

      describe("relationships") {
        let dogName = "dog name A"

        describe("to-one relationship") {
          it("saves the object and its relationship to database correctly") {
            let person = Person(id: personID, name: personName, age: personAge)
            let dog = Dog(value: ["name": dogName])
            dog.owner = person
            let realm = try! Realm()
            try! realm.write {
              realm.add(dog)
            }
            let dogFromDatabase = realm.objects(Dog.self).last
            expect(dogFromDatabase?.name) == dogName
            expect(dogFromDatabase?.owner?.name) == person.name
            expect(dogFromDatabase?.owner?.age) == person.age
          }
        }

        describe("to-many relationship") {
          it("saves the object and its relationship to database correctly") {
            let person = Person(id: personID, name: personName, age: personAge)
            let dog0 = Dog(value: ["name": "dog 0"])
            let dog1 = Dog(value: ["name": "dog 1"])
            person.dogs.append(dog0)
            person.dogs.append(dog1)
            let realm = try! Realm()
            try! realm.write {
              realm.add(person)
            }
            let personFromDatabase = realm.objects(Person.self).last
            expect(personFromDatabase?.dogs.count) == 2
            expect(personFromDatabase?.dogs[0].name) == "dog 0"
            expect(personFromDatabase?.dogs[1].name) == "dog 1"
          }
        }

        describe("inverse relationship") {
          it("saves the object and its relationship to database correctly") {
            let person0 = Person(id: 0, name: "person 0", age: personAge)
            let person1 = Person(id: 1, name: "person 1", age: personAge)
            let dog = Dog(value: ["name": dogName])
            person0.dogs.append(dog)
            person1.dogs.append(dog)
            let realm = try! Realm()
            try! realm.write {
              realm.add(person0)
              realm.add(person1)
            }
            let dogFromDatabase = realm.objects(Dog.self).last
            expect(dogFromDatabase?.owners.count) == 2
            expect(dogFromDatabase?.owners[0].name) == person0.name
            expect(dogFromDatabase?.owners[1].name) == person1.name
          }
        }
      }

      describe("ignored properties") {
        let address = "address here"
        let height = 1.75

        it("doesn't save those properties to database") {
          let person = Person(id: personID, name: personName, age: personAge)
          person.address = address
          person.height = height
          let realm = try! Realm()
          try! realm.write {
            realm.add(person)
          }
          let personFromDatabase = realm.objects(Person.self).last
          expect(personFromDatabase?.address) != address
          expect(personFromDatabase?.height) != height
        }
      }
    }

    describe("CRUD operations") {
      describe("Create") {
        it("saves object to database correctly") {
          let person = Person(id: personID, name: personName, age: personAge)
          person.save()
          let realm = try! Realm()
          let personFromDatabase = realm.objects(Person.self).last
          expect(personFromDatabase?.name) == person.name
          expect(personFromDatabase?.age) == person.age
        }
      }

      describe("Read") {
        beforeEach {
            self.createPersons(number: 3)
        }

        describe("retrieving all objects") {
          it("returns all persons") {
            let persons = Person.all()
            expect(persons.count) == 3
            expect(persons[0].name) == "person 0"
            expect(persons[1].name) == "person 1"
            expect(persons[2].name) == "person 2"
          }
        }

        describe("filtering") {
          it("returns filtered results") {
            let adults = Person.adults()
            expect(adults.count) == 2
            expect(adults[0].age) == 18
            expect(adults[1].age) == 19
          }
        }

        describe("sorting") {
          it("returns sorted results") {
            let results = Person.oldestFirst()
            expect(results.count) == 3
            expect(results[0].age) == 19
            expect(results[1].age) == 18
            expect(results[2].age) == 17
          }
        }

        describe("limiting results") {
          it("returns limited results") {
            let results = Person.first(number: 2)
            expect(results.count) == 2
            expect(results[0].name) == "person 0"
            expect(results[1].name) == "person 1"
          }
        }
      }

      describe("Update") {
        let newName = "new name"
        let newAge = 50
        describe("update properties") {
          it("updates properties to database correctly") {
            let person = Person(id: personID, name: personName, age: personAge)
            person.save()
            person.updateName(name: newName, age: newAge)
            let realm = try! Realm()
            let personFromDatabase = realm.objects(Person.self).last
            expect(personFromDatabase?.name) == newName
            expect(personFromDatabase?.age) == newAge
          }
        }

        describe("update with primary key") {
          context("different id") {
            it("does not update anything") {
              let person = Person(id: 1, name: personName, age: personAge)
              person.save()

              let anotherPerson = Person(id: 2, name:newName, age: newAge)
                person.updateFrom(person: anotherPerson)
              let realm = try! Realm()
              let personFromDatabase = realm.objects(Person.self).last
              expect(personFromDatabase?.name) == personName
              expect(personFromDatabase?.age) == personAge
            }
          }

          context("same id") {
            it("updates properties to database correctly") {
              let person = Person(id: 1, name: personName, age: personAge)
              person.save()

              let anotherPerson = Person(id: 1, name:newName, age: newAge)
                person.updateFrom(person: anotherPerson)
              let realm = try! Realm()
              let personFromDatabase = realm.objects(Person.self).last
              expect(personFromDatabase?.name) == newName
              expect(personFromDatabase?.age) == newAge
            }
          }
        }
      }

      
    }

  }
}

extension PersonSpec {
  func createPersons(number: Int) {
    let realm = try! Realm()
    try! realm.write {
      for i in 0..<number {
        let person = Person(id: i, name: "person \(i)", age: 17 + i)
        realm.add(person)
      }
    }
  }
}
**/
