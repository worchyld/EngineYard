//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 21/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum PlayerState: Int {
    case inactive
    case active
    case thinking
}

final class Player {
    private let uid: UUID = UUID()
    let name: String
    let isAI: Bool

    public private (set) var cash: Int = 0
    public private (set) var asset: String = ""
    lazy var hand: Hand = Hand(owner: self) // hand of cards

    init(name: String, isAI: Bool = true) {
        self.name = name
        self.isAI = isAI
    }
}

extension Player : Equatable {
    public static func ==(lhs: Player, rhs: Player) -> Bool {
        return (lhs.uid == rhs.uid)
    }
}

extension Player : CustomStringConvertible {
    var description: String {
        return ("\(self.name), cash: $\(self.cash)")
    }
}
