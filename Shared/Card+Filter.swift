//
//  Card+Filter.swift
//  EngineYard
//
//  Created by Amarjit on 08/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Filter functions for Card

extension Card {

    // matches on equality
    public static func filter(cards: [Card], matching: (color: Family.Color?, generation: Family.Generation?)) -> [Card] {
        if (matching.color == nil) && (matching.generation == nil) {
            return []
        }

        let results = cards.filter { (c: Card) -> Bool in
            if (matching.color != nil && matching.generation != nil) {
                return (c.color == matching.color!) && (c.generation == matching.generation!)
            }
            else if (matching.color != nil && matching.generation == nil) {
                return (c.color == matching.color)
            }
            else if (matching.color == nil && matching.generation != nil) {
                return (c.generation == matching.generation!)
            }
            else {
                return false
            }
        }.sorted { (a: Card, b: Card) -> Bool in
            if (matching.generation != nil) {
               return ( (a.generation.rawValue < b.generation.rawValue) &&
                        (a.cost < b.cost) )
            }
            else {
                return (a.cost < b.cost)
            }
        }
        return results
    }


}
