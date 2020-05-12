//
//  EY+Enums.swift
//  EngineYard
//
//  Created by Amarjit on 12/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// General Enums used in the game

enum LocomotiveState: Int {
    case inactive = 0
    case active
    case rusting
    case rusted = -1 // Obsolete
}
enum LocomotiveColor: Int, CaseIterable {
    case green = 1  // Passenger
    case red    // Fast
    case yellow // Freight
    case blue   // Special
}
enum LocomotiveGeneration: Int, CaseIterable  {
    case first = 1
    case second
    case third
    case fourth
    case fifth
}
enum OrderState: Int {
    case existingOrder = 0
    case sold
}
