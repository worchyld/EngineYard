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

    func save(game: GameModel, completion: () -> ()) {
        completion()
    }
}
