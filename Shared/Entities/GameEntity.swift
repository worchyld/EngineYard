//
//  GameEntity.swift
//  EngineYard
//
//  Created by Amarjit on 18/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    @objc dynamic var activePlayer: Int = 0
    @objc dynamic var gamePhase: Int = 0

    // RLMRelationships
    //let players = List<PlayerEntity>() // To-many relationship
    //let decks = List<DeckEntity>() // To-many relationship
}
