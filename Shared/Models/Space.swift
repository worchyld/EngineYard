//
//  Space.swift
//  EngineYard
//
//  Created by Amarjit on 01/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Board space

class Space : Codable, Identifiable, Equatable {
    let id: UUID
    let name: String
    let livery: Livery
    let generation: Generation
    var factory: Factory?

    private enum CodingKeys: String, CodingKey {
        case id, name, livery, generation
    }
}

extension Space {
    static func == (lhs: Space, rhs: Space) -> Bool {
        return (lhs.id == rhs.id)
    }
}
