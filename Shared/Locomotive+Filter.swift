//
//  Locomotive+Filter.swift
//  EngineYard
//
//  Created by Amarjit on 24/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

extension Locomotive {

    public static func filter(cards: [Card], on livery: Livery ) -> [Card] {
        cards
            .filter({ $0.livery == livery })
            .sorted { (a: Card, b: Card) -> Bool in
                return (a.cost < b.cost) &&
                    (a.livery.rawValue < b.livery.rawValue) &&
                    (a.generation.rawValue < b.generation.rawValue)
        }
    }

}
