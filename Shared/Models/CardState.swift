//
//  CardState.swift
//  EngineYard
//
//  Created by Amarjit on 19/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

// Obsolescence
public enum CardState : Int {
    case inactive = 1
    case active = 2
    case obsolete = -1

    static let allRawValues = CardState.inactive.rawValue...CardState.obsolete.rawValue
    static let allValues = Array(allRawValues.map{ CardState(rawValue: $0)! })
}
