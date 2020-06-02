//
//  Die.swift
//  EngineYard
//
//  Created by Amarjit on 13/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

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
