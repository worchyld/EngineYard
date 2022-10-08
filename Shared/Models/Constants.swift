//
//  Constants.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation

public struct Constants {
    public static let taxRate: Float = 0.10
    public static let winCondition = 300   // need >=300 after tax to trigger end of game
    
    public struct ValidNumberOfPlayers {
        public static let min = 3
        public static let max = 5
    }
    
    public static let totalDecks = 14
    public static let totalCards = 43
    
    public static let totalTrainPool = 43
    public static let totalMaxDice = 46
    
    public struct Green {
        public static let totalCards = 20
        public static let generations = 5
        public static let maxDicePerGeneration = [3,4,4,5,5]
        public static let trainPoolPerGeneration = [4,4,4,4,4]
    }
    public struct Red {
        public static let totalCards = 13
        public static let generations = 4
        public static let maxDicePerGeneration = [3,3,4,4,0]
        public static let trainPoolPerGeneration = [3,3,3,4,0]
    }
    public struct Yellow {
        public static let totalCards = 7
        public static let generations = 3
        public static let maxDicePerGeneration = [2,3,3,0,0]
        public static let trainPoolPerGeneration = [2,2,3,0,0]
    }
    public struct Blue {
        public static let totalCards = 3
        public static let generations = 2
        public static let maxDicePerGeneration = [1,2,0,0,0]
        public static let trainPoolPerGeneration = [1,2,0,0,0]
    }
}
