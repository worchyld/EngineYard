//
//  TestDBModels.swift
//  EngineYard
//
//  Created by Amarjit on 08/05/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0

    convenience init(name: String, age: Int) {
        self.init()
        self.name = name
        self.age = age
    }
}

class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var owner: Person?
}
