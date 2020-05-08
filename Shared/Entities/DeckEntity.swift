//
//  DeckSpec.swift
//  EngineYard
//
//  Created by Amarjit on 18/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

// [REALM] Deck entity
class DeckEntity : Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var state: Int = 0
    @objc dynamic var color: Int = 0
    @objc dynamic var generation: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var cost: Int = 0
    @objc dynamic var capacity: Int = 0
    @objc dynamic var numberOfChildren: Int = 0

    override static func primaryKey() -> String {
       return "id"
    }

    // RLMRelationships
    let cards = List<CardEntity>() // To-many relationship
    let orders = List<OrderEntity>() // To-many relationship
}

extension DeckEntity {
    override var debugDescription: String {
        let string = "ID: \(self.id), name: \(self.name), cost: \(self.cost), generation:\(self.generation), color: \(self.color), capacity: \(self.capacity), numberOfChildren: \(self.numberOfChildren), #cards: \(self.cards.count)"
        return string
    }
}

extension Deck {

    // Map the entity -> model
    convenience init(from entity: DeckEntity) {
        let name = entity.name
        let cost = entity.cost
        let generation = Deck.Generation.init(rawValue: entity.generation) ?? Deck.Generation.first
        let color = Deck.Color.init(rawValue: entity.color) ?? Deck.Color.green
        let capacity = entity.capacity
        let numberOfChildren = entity.numberOfChildren

        self.init(name: name, cost: cost, generation: generation, color: color, capacity: capacity, numberOfChildren: numberOfChildren)
    }
}

extension DeckEntity {

    // Map the model -> entity
    convenience init(with model: Deck) {
        self.init()
        self.state = model.state.rawValue
        self.color = model.color.rawValue
        self.generation = model.generation.rawValue
        self.name = model.name
        self.cost = model.cost
        self.capacity = model.capacity
        self.numberOfChildren = model.numberOfChildren
    }
}


/*
typealias CompletionHandler = () -> Void


extension DeckEntity {
    public static func saveInBackground(entity: DeckEntity, completion: () -> ()) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()

                realm.beginWrite()
                realm.add(entity)

                try! realm.commitWrite()
            }
        }
        completion()
    }

    public static func save(deck: Deck, completion: CompletionHandler? = nil) {
        let realm = try! Realm()

        let entity: DeckEntity = DeckEntity.init(with: deck)
        
        try! realm.write {
            realm.add(entity)
        }

        completion?()
    }

    func save(completion: (Bool) -> () ) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
        completion(true)
    }

    public static func allRecords(in realm: Realm = try! Realm()) -> Results<DeckEntity> {
        return realm.objects(DeckEntity.self)
        .sorted(byKeyPath: "cost", ascending: true)
    }

    public static func findDecksByName(_ name: String) -> Results<DeckEntity> {
        let realm: Realm = try! Realm()
        let predicate = NSPredicate(format: "name = %@", name)
        return realm.objects(DeckEntity.self).filter(predicate)
    }

    func deleteEntity(completion: CompletionHandler? = nil) {
        do {
            let realm = try Realm()
            do {
                let _ = try realm.write {
                    realm.delete(self)
                }
            } catch let error as NSError {
                print (error.description)
            }
            completion?()
        }
        catch let error as NSError {
            print (error.description)
        }
        completion?()
    }

}
*/
