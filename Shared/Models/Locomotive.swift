//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import Foundation

struct Locomotive: Identifiable, Hashable, Equatable {
    let id: UUID
    let name: String
    let image: String
    let cost: Int
    let livery: Livery
    let generation: Generation
    let rust: Rust
    let available: Bool
}
