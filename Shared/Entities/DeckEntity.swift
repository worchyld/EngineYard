//
//  DeckEntity.swift
//  EngineYard
//
//  Created by Amarjit on 07/05/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class DeckEntity: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var cost : Int = 0
    @objc dynamic var generation : Int = 0
    @objc dynamic var color : Int = 0
    @objc dynamic var numberOfCards : Int = 0
    @objc dynamic var rustedState : Int = 0
    @objc dynamic var active : Bool = false

    let cards = List<CardEntity>()
    let orderBook = List<OrderBookEntity>()
}
