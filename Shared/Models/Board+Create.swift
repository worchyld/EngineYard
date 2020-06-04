//
//  Board+Create.swift
//  EngineYard
//
//  Created by Amarjit on 21/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Board extension
extension Board {

    // Build the board
    // Create board positions
    // Fill each board position with an array of cards that match the color & generation
    static public func create() -> [BoardPosition] {

        let positions = [
            BoardPosition.init(0, cost: 4, color: .green, generation: .first, orderCapacity: 3),
            BoardPosition.init(1, cost: 8, color: .red, generation: .first, orderCapacity: 3),
            BoardPosition.init(2, cost: 12, color: .yellow, generation: .first, orderCapacity: 2),
            BoardPosition.init(3, cost: 16, color: .blue, generation: .first, orderCapacity: 1),
            BoardPosition.init(4, cost: 20, color: .green, generation: .second, orderCapacity: 4),
            BoardPosition.init(5, cost: 24, color: .red, generation: .second, orderCapacity: 3),
            BoardPosition.init(6, cost: 28, color: .yellow, generation: .second, orderCapacity: 3),
            BoardPosition.init(7, cost: 32, color: .green, generation: .third, orderCapacity: 4),
            BoardPosition.init(8, cost: 36, color: .blue, generation: .second, orderCapacity: 2),
            BoardPosition.init(9, cost: 40, color: .red, generation: .third, orderCapacity: 4),
            BoardPosition.init(10, cost: 44, color: .green, generation: .fourth, orderCapacity: 5),
            BoardPosition.init(11, cost: 48, color: .yellow, generation: .third, orderCapacity: 3),
            BoardPosition.init(12, cost: 52, color: .red, generation: .fourth, orderCapacity: 4),
            BoardPosition.init(13, cost: 54, color: .green, generation: .fifth, orderCapacity: 5)
        ]

        let cards = Card.createAllCards()

        // walk through each position in the board then add the cards to that array
        //self.positions.mutateEach { (position) in
        //    position.cards = Board.get(cards: cards, whereColor: position.color, whereGeneration: position.generation)
        //}
        positions.forEach { (position) in
            position.cards = Board.get(cards: cards, whereColor: position.color, whereGeneration: position.generation)
        }

        return positions
    }
}


// Board common functions
extension Board {
    private func getAllCards() -> [Card] {
        let allCards = self.positions.compactMap({$0.cards}).flatMap { $0 }
        return allCards
    }

    public func getAllCardsThatMatch(color: Family.Color) -> [Card] {
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

    public func getAllCardsThatMatch(generation: Family.Generation) -> [Card] {
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

    public func getAllCardsThatMatch(color: Family.Color, andGeneration: Family.Generation) -> [Card] {
        let cards = self.getAllCards()

        let results = Board.get(cards: cards, whereColor: color, whereGeneration: andGeneration)

        return results
    }

    public static func get(cards: [Card], whereColor: Family.Color, whereGeneration: Family.Generation) -> [Card] {
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
