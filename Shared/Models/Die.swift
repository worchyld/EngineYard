//
//  Die.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

extension Int {
    var isD6 : Bool {
        guard self >= Die.minimumValue && self <= Die.maximumValue else {
            return false
        }
        return true
    }
}

struct Die: Equatable {
    public static let minimumValue = 1
    public static let maximumValue = 6
    
    public static var roll: Int {
        if #available(iOS 9, *) {
            let d6 = GKRandomDistribution.d6()
            return (d6.nextInt())
        }
        else {
            return Int.random(in: 1...6)
        }
    }
}

extension Die {
    static func increment(value: Int, by amount: Int) -> Int {
        var value = value
        guard ((value + amount) < Die.maximumValue) else {
            return value
        }
        value += 1
        return value
    }
    static func decrement(value: Int, by amount: Int) -> Int {
        var value = value
        guard ((value - amount) > Die.minimumValue) else {
            return value
        }
        value -= 1
        return value
    }
}
