//
//  D6.swift
//  EngineYard
//
//  Created by Amarjit on 13/04/2023.
//

import Foundation
import GameplayKit

struct D6 {
    public static let minimumValue = 1
    public static let maximumValue = 6
    
    public static var roll: Int {
        if #available(iOS 9, *) {
            let d6 = GKRandomDistribution.d6()
            return (d6.nextInt())
        }
        else {
            return Int.random(in: D6.minimumValue...D6.maximumValue)
        }
    }
}

extension D6 {
    static func increment(value: Int, by amount: Int) -> Int {
        var value = value
        guard ((value + amount) < D6.maximumValue) else {
            return value
        }
        value += 1
        return value
    }
}
