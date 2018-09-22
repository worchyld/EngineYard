//
//  Selling.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// handles selling?

class Selling : NSObject {

    var decks : [Deck] = [Deck]()

    init(decks: [Deck]) {
        super.init()
        self.decks = decks
    }

}
