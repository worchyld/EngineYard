//
//  RustingState.swift
//  EngineYard
//
//  Created by Amarjit on 16/01/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

// Obsolescence state
enum RustedState : Int {
    case normal
    case old
    case obsolete

    static let allRawValues = RustedState.normal.rawValue...RustedState.obsolete.rawValue
    static let allValues = Array(allRawValues.map{ RustedState(rawValue: $0)! })
}
