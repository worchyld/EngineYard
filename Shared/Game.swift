//
//  Game.swift
//  EngineYard
//
//  Created by Amarjit on 20/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// Game model
final class Game : NSObject {
    // Create a static, constant instance of
    // the enclosing class (itself) and initialize.
    static let instance = Game()

    var board: Board!
    var players: [Player] = [Player]()
    var activePlayer: Player?

    public static func setup(with players:[Player]) -> Game? {
        return (GameSetupManager().setup(with: players))
    }
}

extension Game {
    func isEndGameConditionMet() -> Bool {
        guard let active = self.activePlayer else {
            return false
        }
        return (Rules.isGameEndConditionMet(active.cash))
    }
}
