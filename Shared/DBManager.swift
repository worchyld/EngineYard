//
//  DBManager.swift
//  EngineYard
//
//  Created by Amarjit on 07/05/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager {
    static func save (object: Object, completion: @escaping () -> Void) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                realm.beginWrite()
                realm.add(object)
                try! realm.commitWrite()
                completion()
            }
        }
    }

    static func save (objects: [Object], completion: @escaping () -> Void) {
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(objects)
        try! realm.commitWrite()
        completion()
    }

    static func delete (object: Object, completion: @escaping () -> Void) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                realm.beginWrite()
                realm.delete(object)
                try! realm.commitWrite()
                completion()
            }
        }
    }

    static func clearAll() {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                realm.beginWrite()
                realm.deleteAll()
                try! realm.commitWrite()
            }
        }
    }

    static func clearAll(completion: @escaping () -> Void) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                realm.beginWrite()
                realm.deleteAll()
                try! realm.commitWrite()
                completion()
            }
        }

    }

}
