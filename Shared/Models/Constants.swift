//
//  Constants.swift
//  EngineYard
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation

// Game constants

public struct Constants {
    public static let taxRate: Float = 0.10
    public static let endGameTriggerCash = 330 // need >=300 after tax to trigger end of game
    
    public struct NumberOfPlayers {
        public static let min = 3
        public static let max = 5
        
        public static func seedCash(players: Int) -> Int {
            switch players {
            case 3,4: return 12
            case 5: return 14
            default: return 0
            }
        }
        
        public static func isValid(_ playerCount: Int = NumberOfPlayers.min) -> Bool {
            return (playerCount >= NumberOfPlayers.min && playerCount <= NumberOfPlayers.max)
        }
    }
    
    public struct Trains {
        public static let total = 14 // total number of decks in the game
        public static let totalCards = 43 // total number of cards in the game
        public static let totalDicePoolCapacity = 46 // for dice
    }
    
    public struct Green {
        public static let totalCards = 20
        public static let totalGenerations = 5
        public static let diceCapacityPerGeneration = [3,4,4,5,5]
        public static var totalDiceCapacity: Int {
            return diceCapacityPerGeneration.reduce(0, +)
        }
    }
    public struct Red {
        public static let totalCards = 13
        public static let totalGenerations = 4
        public static let diceCapacityPerGeneration = [3,3,4,4,0]
        public static var totalDiceCapacity: Int {
            return diceCapacityPerGeneration.reduce(0, +)
        }
    }
    public struct Yellow {
        public static let totalCards = 7
        public static let totalGenerations = 3
        public static let diceCapacityPerGeneration = [2,3,3,0,0]
        public static var totalDiceCapacity: Int {
            return diceCapacityPerGeneration.reduce(0, +)
        }
    }
    public struct Blue {
        public static let totalCards = 3
        public static let totalGenerations = 2
        public static let diceCapacityPerGeneration = [1,2,0,0,0]
        public static var totalDiceCapacity: Int {
            return diceCapacityPerGeneration.reduce(0, +)
        }
    }
}
