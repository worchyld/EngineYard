//
//  Locomotive+Group.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol LocomotiveGroupDelegate {
    var color: Locomotive.Color { get }
    var generation: Locomotive.Generation { get }
}

// In the game cards `belong` to a group / family / collection
// A group is considered a color (Int) and a generation (Int)
// IE: Green 1st Generation, Red 2nd Generation, etc

struct LocomotiveGroup : LocomotiveGroupDelegate, Hashable {
    var color: Locomotive.Color
    var generation: Locomotive.Generation

    public func hash(into hasher: inout Hasher) {
        hasher.combine(color.hashValue)
        hasher.combine(generation.hashValue)
    }
}

extension LocomotiveGroup : CustomStringConvertible {
    var description: String {
        let colorAsString = String(describing: self.color).capitalizingFirstLetter()
        let ordinalFormat = self.generation.ordinalFormat ?? "0"
        let generationAsString = ordinalFormat + " Generation"
        return colorAsString + " " + generationAsString
    }
}
