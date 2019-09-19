//
//  CardColor.swift
//  EngineYard
//
//  Created by Amarjit on 19/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum CardColor: Int {
    case green = 1  // Passenger
    case red    // Fast
    case yellow // Freight
    case blue   // Special

    static let allRawValues = CardColor.green.rawValue...CardColor.blue.rawValue
    static let allValues = Array(allRawValues.map{ CardColor(rawValue: $0)! })
}
