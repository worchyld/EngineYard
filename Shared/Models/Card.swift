//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 01/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct Card : Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let avatar: String
    let cost: Int
    let livery: Livery
    let generation: Generation
    //var production: Int
    //var spentProduction: Int
    //var owner: Player?

    // codingkeys
    private enum CodingKeys: String, CodingKey {
        case id, name, avatar, cost, livery, generation
        //case production, spentProduction, owner
    }
}

extension Card {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return (lhs.id == rhs.id)
    }
}
