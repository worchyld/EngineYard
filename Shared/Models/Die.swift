//
//  Die.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

struct D6 {
    public private (set) var value: Int
    
    init() {
        self.value = Die.roll
    }
    
    public mutating func decrement() {
        guard self.value > 1 else {
            return 
        }
        self.value = self.value - 1
    }
}

struct Die: Equatable {
    public static var roll: Int {
        if #available(iOS 9, *) {
            let d6 = GKRandomDistribution.d6()
            return (d6.nextInt())
        }
        else {
            let d6 = 6
            return Int.randomInt(withMax: d6)
        }
    }
}
