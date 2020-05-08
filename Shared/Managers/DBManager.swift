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
    static var shared = DBManager()

    private init() {}

    func save(gameModel: GameModel, completion: (Bool) -> ()) {
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
        entity.hasMusic = gameModel.music
        entity.hasSound = gameModel.sound
        entity.turnOrderIndex = gameModel.turnOrderIndex

        let realm = try! Realm()

        realm.beginWrite()
        realm.add(entity)
        try! realm.commitWrite()

        completion(true)
    }

    //: (Private) funcs

    private func save(decks: [Deck], completion: () -> ()) {
        completion()
    }

    private func save(cards:[Card], completion: () -> ()) {
        completion()
    }

    private func save(players:[Player], completion: () -> ()) {
        completion()
    }


    private func saveState(completion: () -> ()) {
        completion()
    }

    private func loadState(completion: () -> ()) {
        completion()
    }
}
