//
//  Generation.swift
//  EngineYard
//
//  Created by Amarjit on 19/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

public enum Generation: Int {
    case first = 1
    case second
    case third
    case fourth
    case fifth

    static let allRawValues = Generation.first.rawValue...Generation.fifth.rawValue
    static let allValues = Array(allRawValues.map{ Generation(rawValue: $0)! })
}
