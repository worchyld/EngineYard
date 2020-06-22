//
//  Livery.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum Livery : Int, CaseIterable, Codable {
    case green = 1, red, blue, yellow
}

extension Livery {
    enum CodingKeys: Int, CodingKey {
        case green, red, blue, yellow
    }
}

extension Livery {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let key = container.allKeys.first

        print (key as Any)

        switch key {
        case .green:
            self = try container.decode(Livery.self, forKey: .green)
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode enum."
                )
            )
        }
    }
}
