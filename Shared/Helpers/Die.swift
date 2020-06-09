//
//  Die.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

// Simple die randomizer

struct Die: Equatable {
    public static var roll: Int {
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
