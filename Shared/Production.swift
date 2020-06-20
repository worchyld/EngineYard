//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 19/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class Production : Identifiable {
    let id: UUID
    let units: Int
    let spent: Int = 0

    init(_ id: UUID = UUID(), units: Int = 0) {
        self.id = id
        self.units = units
    }
}
