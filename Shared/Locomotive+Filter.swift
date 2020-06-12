//
//  Locomotive+Filter.swift
//  EngineYard
//
//  Created by Amarjit on 11/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Filter on the array of locomotives held by the board
extension Locomotive {
    public static func filter(locomotives: [Locomotive], on color: Family.Color) -> [Locomotive]? {
        let filtered = locomotives.filter { (locomotive) -> Bool in
            return locomotive.color == color
        }.sorted { (a: Locomotive, b: Locomotive) -> Bool in
            return ( (a.cost < b.cost) && (a.generation.rawValue < b.generation.rawValue) )
        }
        return filtered
    }

    public static func filter(locomotives: [Locomotive], on generation: Family.Generation) -> [Locomotive]? {
        let filtered = locomotives.filter { (locomotive) -> Bool in
            return locomotive.generation == generation
        }.sorted { (a: Locomotive, b: Locomotive) -> Bool in
            return ( (a.cost < b.cost) && (a.generation.rawValue < b.generation.rawValue) )
        }

        return filtered
    }
}
