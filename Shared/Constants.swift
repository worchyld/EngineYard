//
//  Constants.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

public struct Constants {
    // Game ends when a player hits 330 coins or more
    public static let endGameCashTrigger: Int = 330

    public struct SeedCash {
        public static let threePlayer: Int = 12
        public static let fivePlayer: Int = 14
    }

    public struct ValidNumberOfPlayers {
        public static let min: Int = 3
        public static let max: Int = 5

        static func isValid( _ numberOfPlayers: Int) -> Bool {
            let min = Constants.ValidNumberOfPlayers.min
            let max = Constants.ValidNumberOfPlayers.max
            guard ((min ... max).contains(numberOfPlayers)) else {
                return false
            }
            return true
        }
    }

    public static func hasReachedGoal(_ cash: Int) -> Bool {
        return (cash >= Constants.endGameCashTrigger)
    }
}
