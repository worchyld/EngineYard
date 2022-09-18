//
//  Constants.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation

public struct Constants {
    public static let taxRate: Float = 0.10
    
    public static let totalDecks = 14
    public static let totalCards = 43
    
    public struct Green {
        public static let totalCards = 20
        public static let generations = 5
        public static let cardsPerGeneration = [4,4,4,4,4]
    }
    public struct Red {
        public static let totalCards = 13
        public static let generations = 4
        public static let cardsPerGeneration = [3,3,4,0,0]
    }
    public struct Yellow {
        public static let totalCards = 7
        public static let generations = 3
        public static let cardsPerGeneration = [2,2,3,0,0]
    }
    public struct Blue {
        public static let totalCards = 3
        public static let generations = 2
        public static let cardsPerGeneration = [1,2]
    }
}
