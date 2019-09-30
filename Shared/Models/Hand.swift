//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum HandError: Error {
    case alreadyHave(card: Card)
    case cannotFind(card: Card)
    case handIsEmpty
    case handHasNoOwner
}

struct Hand {
    let cards: [Card]
}

extension Hand: CustomStringConvertible {
    var description: String {
        return ("Hand cards #\(self.cards.count)")
    }
}
