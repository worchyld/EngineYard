//
//  CardEntity.swift
//  EngineYard
//
//  Created by Amarjit on 07/05/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class CardEntity: Object {
    @objc dynamic var name : String = UUID().uuidString
    @objc dynamic var income : Int = 0

    let parent = LinkingObjects(fromType: DeckEntity.self, property: "cards")
    let owner = LinkingObjects(fromType: PlayerEntity.self, property: "hand")
    let production = List<ProductionEntity>()
}
