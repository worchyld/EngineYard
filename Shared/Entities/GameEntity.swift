//
//  GameEntity.swift
//  EngineYard
//
//  Created by Amarjit on 18/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

//private let uniqueId = "84259842-D756-4E5C-923E-747A79B5EC62"

class GameEntity: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var activePlayer: Int = 0
    @objc dynamic var turnOrderIndex: Int = 0
    @objc dynamic var gamePhase: Int = 0
    @objc dynamic var page: String = ""
    @objc dynamic var hasSound: Bool = false
    @objc dynamic var hasMusic: Bool = false

    override static func primaryKey() -> String {
       return "id"
    }
}

extension GameEntity {
    // Map from model -> entity
    convenience init(from model: GameModel) {
        self.init()
        self.gamePhase = model.phase?.rawValue ?? 0
        self.hasSound = model.sound as Bool
        self.hasMusic = model.music as Bool
        self.activePlayer = model.activePlayer?.playerId ?? 0
        self.turnOrderIndex = model.turnOrderIndex
    }
}

extension GameModel {
    // Map from entity -> model
    convenience init(from entity: GameEntity) {
        self.init()
        self.sound = Bool(entity.hasSound)
        self.music = Bool(entity.hasMusic)
        self.phase = GamePhase.init(rawValue: entity.gamePhase)
        self.turnOrderIndex = entity.turnOrderIndex
    }
}
