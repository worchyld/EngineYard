//
//  Space.swift
//  EngineYard
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// The board is a linear collection of spaces.
// Each space holds a `LocomotiveFactory` (AKA: Factory)
// Each `factory` holds multiple `Locomotive` (AKA Card)

// MARK: - Space
struct Space: Codable, Identifiable {
    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id, name = "name"
    }
}

extension Space {
    static func == (lhs: Space, rhs: Space) -> Bool {
        return (lhs.id == rhs.id)
    }
}
