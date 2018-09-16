//
//  ObsolescenceManager.swift
//  EngineYard
//
//  Created by Amarjit on 16/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

struct ObsolescenceManager {

    private var _decks: [Deck]

    init(decks: [Deck]) {
        self._decks = decks
    }

    func findGenerations(for color: EngineColor) -> Int {
        guard let generations = Board.findActiveGenerations(in: _decks, color: color) else {
            return 0
        }

        print ("Found: \(generations.count) generations")

        return generations.count
    }

    func handleGenerations(for color: EngineColor) {
    }

}
