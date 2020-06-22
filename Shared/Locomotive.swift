//
//  Locomotive.swift
//  EngineYardTests
//
//  Created by Amarjit on 21/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias Card = Locomotive

// MARK: - Locomotive
struct Locomotive: Codable {
    let id, ref, name, avatar: String
    let cost: Int, generation: Generation
    let livery: Livery
}
