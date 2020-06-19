//
//  EY+Int.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Int extensions

extension Int {
    static func randomInt(withMax: Int) -> Int {
        let maximum = UInt32(withMax)
        return 1 + Int(arc4random_uniform(maximum))
    }
}

extension Int {
    var isPositive: Bool {
        return (self > 0)
    }
    var isNegative: Bool {
        return (self < 0)
    }
}
