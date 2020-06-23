//
//  Response.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct Response: Codable {
    var meta: Meta?
    var factories: [Factory]?
    var spaces: [Space]?
    var locomotives: [Locomotive]?

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case factories, spaces, locomotives
    }
}
