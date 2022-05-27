//
//  LocomotiveViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 07/03/2022.
//

import Foundation


// Used in the views

struct LocomotiveViewModel: LocomotiveDelegate, Identifiable, Hashable, Equatable {
    let id: UUID
    let name: String
    let image: String
    let cost: Int
    let livery: Livery
    let generation: Generation
    var rust: Rust
    var available: Bool
}
