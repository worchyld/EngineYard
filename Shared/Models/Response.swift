//
//  Response.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct Response: Codable {
    var trains: [Train]?

    enum CodingKeys: String, CodingKey {
        case trains
    }
}
