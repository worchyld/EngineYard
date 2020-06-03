//
//  CardViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 03/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Card view model for a single card
struct CardViewModel {
    let card: Card

    init(card: Card) {
        self.card = card
    }
}
