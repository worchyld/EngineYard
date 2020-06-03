//
//  CardListViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 03/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// View model to show a list of cards
struct CardListViewModel {
    let position: BoardPosition!
    var cards: [Card] {
        return self.position.cards
    }
    var pageTitle: String {
        return ("\(self.position.name) cards")
    }


    init(position: BoardPosition) {
        self.position = position
    }
}
