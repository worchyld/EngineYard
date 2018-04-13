//
//  Enums.swift
//  EngineYard
//
//  Created by Amarjit on 13/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
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


enum EngineColor: Int {
    case green = 1  // Passenger
    case red    // Fast
    case yellow // Freight
    case blue   // Special

    static let allRawValues = EngineColor.green.rawValue...EngineColor.blue.rawValue
    static let allValues = Array(allRawValues.map{ EngineColor(rawValue: $0)! })
}
