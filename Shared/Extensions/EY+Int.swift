//
//  EY+Int.swift
//  EngineYardTests
//
//  Created by Amarjit on 11/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

extension Int {
    static func randomInt(withMax: Int) -> Int {
        let maximum = UInt32(withMax)
        return 1 + Int(arc4random_uniform(maximum))
    }
}
