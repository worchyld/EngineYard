//
//  Rules.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

struct Constants {
    public static let taxRate: Float = 0.10 // Players pay 10% of their cash in taxes, rounded down
    public static let endGameCashTrigger: Int = 330 // Game ends when a player hits 330 coins or more
    public static let threePlayerSeedCash: Int = 12
    public static let fivePlayerSeedCash: Int = 14

    public static func hasReachedGoal(_ cash: Int) -> Bool {
        return (cash >= Constants.endGameCashTrigger)
    }

    public struct Players {
        public static let min: Int = 3
        public static let max: Int = 5

        public static func valid(_ numberOfPlayers: Int) -> Bool {
            /*guard ((Constants.Players.min ... Constants.Players.max).contains(numberOfPlayers)) else {
                throw ErrorCode.invalidNumberOfPlayers
            }*/
            guard ((Constants.Players.min ... Constants.Players.max).contains(numberOfPlayers)) else {
                return false
            }
            return true
        }

        public static func getSeedCash(for numberOfPlayers: Int) -> Int? {
            switch numberOfPlayers {
            case 3:
                return threePlayerSeedCash
            case 4, 5:
                return fivePlayerSeedCash
            default:
                return nil
            }
        }
    }
}
