//
//  Generations.swift
//  EngineYard
//
//  Created by Amarjit on 26/12/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
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
