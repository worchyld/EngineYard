//
//  LocomotiveLivery.swift
//  EngineYard
//
//  Created by Amarjit on 18/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

extension Locomotive {
    public enum Color: Int, CaseIterable {
        case green = 1, red, yellow, blue

        static let allRawValues = Locomotive.Color.green.rawValue...Locomotive.Color.blue.rawValue
    }
}
