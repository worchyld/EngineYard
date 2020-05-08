//
//  DBManager.swift
//  EngineYard
//
//  Created by Amarjit on 08/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift

final class DBManager {
    static var instance = DBManager()

    private init() {}

    func saveState(completion: () -> ()) {
        completion()
    }

    func loadState(completion: () -> ()) {
        completion()
    }

    //: (Private) funcs

    private func save(gameModel: GameModel, completion: () -> ()) {
        guard let gamePhase = gameModel.phase else {
            print ("No game phase defined")
            return
        }
        guard let activePlayer = gameModel.activePlayer else {
            print ("No activePlayer defined")
            return
        }

        let entity = GameEntity.init()
        entity.gamePhase = gamePhase.rawValue
        entity.activePlayer = activePlayer.playerId
        entity.hasMusic = Settings().music as Bool
        entity.hasSound = Settings().sound as Bool
        entity.turnOrderIndex = gameModel.turnOrderIndex

        let realm = try! Realm()

        try! realm.write {
           realm.add(entity)
        }

        completion()
    }

    private func save(decks: [Deck], completion: () -> ()) {
        completion()
    }

    private func save(cards:[Card], completion: () -> ()) {
        completion()
    }

    private func save(players:[Player], completion: () -> ()) {
        completion()
    }

    private func save(settings:Settings, completion: () -> ()) {
        completion()
    }
}
