//
//  Response.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct Response: Codable {
    var spaces: [Space]?
    var factories: [Factory]?

    enum CodingKeys: String, CodingKey {
        case spaces, factories
    }
}
