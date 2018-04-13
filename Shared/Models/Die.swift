//
//  Die.swift
//  EngineYard
//
//  Created by Amarjit on 27/10/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

extension Int {
    static func randomInt(withMax: Int) -> Int {
        let maximum = UInt32(withMax)
        return 1 + Int(arc4random_uniform(maximum))
    }
}

struct Die {
    static func roll() -> Int {
        if #available(iOS 9, *) {
            let d6 = GKRandomDistribution.d6()
            return (d6.nextInt())
        }
        else {
            let d6 = 6
            return Int.randomInt(withMax:d6)
        }
    }
}

extension Die {
    static func asset(die: Int) -> String {
        return "die-face-\(die)"
    }
}

