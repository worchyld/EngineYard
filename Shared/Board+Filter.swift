//
//  Board+Filter.swift
//  EngineYard
//
//  Created by Amarjit on 09/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Filter extension for the board

extension Board {

    func findAllDecks(with state: Deck.State) -> [Deck?] {
        let results = self.filter { (deck: Deck?) -> Bool in
            guard let d = deck else {
                return false
            }
            return (d.state == state)
        }

        return results
    }

}
