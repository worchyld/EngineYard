//
//  GameBoard.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

protocol GameBoardDelegate {
    func unlockNextDeck( _ deck: Deck )
}

class Board : NSObject, GameBoardDelegate {
    static let sharedInstance = Board()

    private var _decks: [Deck] = [Deck]()

    public var countUnlocked : Int {
        return (self.decks.reduce(0) { $0 + ($1.active ? 1 : 0) })
    }

    public var decks: [Deck] {
        return self._decks.sorted(by: { (t1: Deck, t2: Deck) -> Bool in
            return (t1.cost < t2.cost)
        })
    }

    override init() {
        super.init()
        self._decks = prepare()
    }


    override var description: String {
        return "Board. Decks: \(self.decks.count)"
    }

    // Prepare game decks
    func prepare() -> [Deck] {
        let decks = [
            Deck.init(name: "Green.1", cost: 4, generation: .first, color: .green, capacity: 3, numberOfChildren: 4)
            , Deck.init(name: "Red.1", cost: 8, generation: .first, color: .red, capacity: 3, numberOfChildren: 3)
            , Deck.init(name: "Yellow.1", cost: 12, generation: .first, color: .yellow, capacity: 2, numberOfChildren: 2)
            , Deck.init(name: "Blue.1", cost: 16, generation: .first, color: .blue, capacity: 1, numberOfChildren: 1)
            , Deck.init(name: "Green.2", cost: 20, generation: .second, color: .green, capacity: 4, numberOfChildren: 4)
            , Deck.init(name: "Red.2", cost: 24, generation: .second, color: .red, capacity: 3, numberOfChildren: 3)
            , Deck.init(name: "Yellow.2", cost: 28, generation: .second, color: .yellow, capacity: 3, numberOfChildren: 2)
            , Deck.init(name: "Green.3", cost: 32, generation: .third, color: .green, capacity: 4, numberOfChildren: 4)
            , Deck.init(name: "Blue.2", cost: 36, generation: .second, color: .blue, capacity: 2, numberOfChildren: 2)
            , Deck.init(name: "Red.3", cost: 40, generation: .third, color: .red, capacity: 4, numberOfChildren: 3)
            , Deck.init(name: "Green.4", cost: 44, generation: .fourth, color: .green, capacity: 5, numberOfChildren: 4)
            , Deck.init(name: "Yellow.3", cost: 48, generation: .third, color: .yellow, capacity: 3, numberOfChildren: 3)
            , Deck.init(name: "Red.4", cost: 52, generation: .fourth, color: .red, capacity: 4, numberOfChildren: 4)
            , Deck.init(name: "Green.5", cost: 56, generation: .fifth, color: .green, capacity: 5, numberOfChildren: 4)
        ]

        // add deck subscriber
        let _ = decks.map({
            $0.addSubscriber(self)
        })

        return decks
    }
}

extension Board {
    internal func unlockNextDeck(_ deck: Deck) {
        guard let nextDeck = self.decks.after(deck) else {
            return
        }

        guard (nextDeck.active == false) else {
            return
        }

        nextDeck.unlock()
    }
}
