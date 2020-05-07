//
//  Winner.swift
//  EngineYard
//
//  Created by Amarjit on 24/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

struct Winner {
    private let players: [Player]
    lazy var sorted: [Player] = {
        let sorted = self.players.sorted(by: { (p1, p2) -> Bool in
            return (p1.cash > p2.cash)
        })
        return sorted
    }()

    init(players: [Player]) {
        self.players = players
    }
}

extension Winner {
    mutating func getFirstPrize() -> Player? {
        guard let firstPrize = self.sorted.first else {
            return nil
        }
        return firstPrize
    }
}
