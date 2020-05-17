//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 17/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// : Represents the gameboard
// The gameboard has a number of positions.
// Each position holds a stack/array/collection of cards
// A position has a `state`
struct Board {
    private(set) var positions: [BoardPosition]    

    // Build the board
    // Create board positions
    // Fill each board position with an array of cards that match the color & generation
    init() {
        let positions = [
            BoardPosition.init(0, color: .green, generation: .first, orderCapacity: 3),
            BoardPosition.init(1, color: .red, generation: .first, orderCapacity: 3),
            BoardPosition.init(2, color: .yellow, generation: .first, orderCapacity: 2),
            BoardPosition.init(3, color: .blue, generation: .first, orderCapacity: 1),
            BoardPosition.init(4, color: .green, generation: .second, orderCapacity: 4),
            BoardPosition.init(5, color: .red, generation: .second, orderCapacity: 3),
            BoardPosition.init(6, color: .yellow, generation: .second, orderCapacity: 3),
            BoardPosition.init(7, color: .green, generation: .third, orderCapacity: 4),
            BoardPosition.init(8, color: .blue, generation: .second, orderCapacity: 2),
            BoardPosition.init(9, color: .red, generation: .third, orderCapacity: 4),
            BoardPosition.init(10, color: .green, generation: .fourth, orderCapacity: 5),
            BoardPosition.init(11, color: .yellow, generation: .third, orderCapacity: 3),
            BoardPosition.init(12, color: .red, generation: .fourth, orderCapacity: 4),
            BoardPosition.init(13, color: .green, generation: .fifth, orderCapacity: 5)
        ]
        self.positions = positions
        let cards = self.buildCards()

        // walk through each position in the board then add the cards to that array
        self.positions.mutateEach { (position) in
            position.cards = Board.get(cards: cards, whereColor: position.color, whereGeneration: position.generation)
        }

    }
}

extension Board {
    private func buildCards() -> [Card] {
        let cards = [
            // Green.first (x4)
            Card.init(cost: 4, color: .green, generation: .first),
            Card.init(cost: 4, color: .green, generation: .first),
            Card.init(cost: 4, color: .green, generation: .first),
            Card.init(cost: 4, color: .green, generation: .first),

            // Red.first (x3)
            Card.init(cost: 8, color: .red, generation: .first),
            Card.init(cost: 8, color: .red, generation: .first),
            Card.init(cost: 8, color: .red, generation: .first),

            // Yellow.first (x2)
            Card.init(cost: 12, color: .yellow, generation: .first),
            Card.init(cost: 12, color: .yellow, generation: .first),

            // Blue.first (x1)
            Card.init(cost: 16, color: .blue, generation: .first),

            // Green.second (x4)
            Card.init(cost: 20, color: .green, generation: .second),
            Card.init(cost: 20, color: .green, generation: .second),
            Card.init(cost: 20, color: .green, generation: .second),
            Card.init(cost: 20, color: .green, generation: .second),

            // Red.second (x3)
            Card.init(cost: 24, color: .red, generation: .second),
            Card.init(cost: 24, color: .red, generation: .second),
            Card.init(cost: 24, color: .red, generation: .second),

            // Yellow.second (x2)
            Card.init(cost: 28, color: .yellow, generation: .second),
            Card.init(cost: 28, color: .yellow, generation: .second),

            // Green.third (x4)
            Card.init(cost: 32, color: .green, generation: .third),
            Card.init(cost: 32, color: .green, generation: .third),
            Card.init(cost: 32, color: .green, generation: .third),
            Card.init(cost: 32, color: .green, generation: .third),

            // Blue.second (x2)
            Card.init(cost: 36, color: .blue, generation: .second),
            Card.init(cost: 36, color: .blue, generation: .second),

            // Red.third (x3)
            Card.init(cost: 40, color: .red, generation: .third),
            Card.init(cost: 40, color: .red, generation: .third),
            Card.init(cost: 40, color: .red, generation: .third),

            // Green.fourth (x4)
            Card.init(cost: 44, color: .green, generation: .fourth),
            Card.init(cost: 44, color: .green, generation: .fourth),
            Card.init(cost: 44, color: .green, generation: .fourth),
            Card.init(cost: 44, color: .green, generation: .fourth),

            // Yellow.third (x3)
            Card.init(cost: 48, color: .yellow, generation: .third),
            Card.init(cost: 48, color: .yellow, generation: .third),
            Card.init(cost: 48, color: .yellow, generation: .third),

            // Red.fourth (x4)
            Card.init(cost: 52, color: .red, generation: .fourth),
            Card.init(cost: 52, color: .red, generation: .fourth),
            Card.init(cost: 52, color: .red, generation: .fourth),
            Card.init(cost: 52, color: .red, generation: .fourth),

            // Green.fifth (x4)
            Card.init(cost: 56, color: .green, generation: .fifth),
            Card.init(cost: 56, color: .green, generation: .fifth),
            Card.init(cost: 56, color: .green, generation: .fifth),
            Card.init(cost: 56, color: .green, generation: .fifth)
        ]

        return cards
    }
}

extension Board {
    private func getAllCards() -> [Card] {
        let allCards = self.positions.compactMap({$0.cards}).flatMap { $0 }
        return allCards
    }

    public func getAllCardsThatMatch(color: FamilyColor) -> [Card] {
        let cards = self.getAllCards()

        let results = cards.filter { (c: Card) -> Bool in
            return (c.color == color)
        }.sorted { (a: Card, b: Card) -> Bool in
            return (
                (a.color.rawValue < b.color.rawValue) &&
                (a.cost < b.cost)
            )
        }
        return results
    }

    public func getAllCardsThatMatch(generation: FamilyGeneration) -> [Card] {
        let cards = self.getAllCards()

        let results = cards.filter { (c: Card) -> Bool in
            return (c.generation == generation)
        }.sorted { (a: Card, b: Card) -> Bool in
            return (
                (a.generation.rawValue < b.generation.rawValue) &&
                (a.cost < b.cost)
            )
        }
        return results
    }

    public func getAllCardsThatMatch(color: FamilyColor, andGeneration: FamilyGeneration) -> [Card] {
        let cards = self.getAllCards()

        let results = Board.get(cards: cards, whereColor: color, whereGeneration: andGeneration)

        return results
    }

    public static func get(cards: [Card], whereColor: FamilyColor, whereGeneration: FamilyGeneration) -> [Card] {
        let results = cards.filter { (c: Card) -> Bool in
            return (c.color == whereColor) && (c.generation == whereGeneration)
        }.sorted { (a: Card, b: Card) -> Bool in
            return (a.cost < b.cost)
        }
        return results
    }



    // to be removed
    func printAllCards() {
        let cards = self.getAllCards()
        for (index, card) in cards.enumerated() {
            print ("#\(index): Card -- \(card.description)")
        }

        print (cards.count)
    }
}
