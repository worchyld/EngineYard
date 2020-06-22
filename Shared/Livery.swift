//
//  Livery.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum Livery : Codable {
    case green, red, blue, yellow

    private enum RawValue: Int, Codable, CaseIterable {
        case green = 1, red , yellow, blue
    }

    private enum CodingKeys: Int, CodingKey {
        case green, red, blue, yellow
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let key = container.allKeys.first

        switch key {
        case .green:
            self = .green
        case .red:
            self = .red
        case .yellow:
            self = .yellow
        case .blue:
            self = .blue

        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Error -- Unabled to decode."
                )
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        switch self {
        case .green:
            try container.encode(RawValue.green)
        case .red:
            try container.encode(RawValue.red)
        case .yellow:
            try container.encode(RawValue.yellow)
        case .blue:
            try container.encode(RawValue.blue)
//        default:
//            let context = EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Invalid value")
//            throw EncodingError.invalidValue(self, context)
        }

    }

}
