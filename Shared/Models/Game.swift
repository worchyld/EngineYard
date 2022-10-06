//
//  Game.swift
//  EngineYard
//
//  Created by Amarjit on 28/05/2022.
//

import Foundation

class Game {
    var board: Board?
    var players: [Player]?
    var gamePhase: GamePhase = .setup
}

extension Game {
    func didEndTrigger(cash: Int) -> Bool {
        return (cash >= Constants.winCondition)
    }
    func winnersList() -> [Player]? {
        guard let pl = players else {
            return nil
        }
        let sortedByMostCoins = pl.sorted(by: { p1, p2 in
            return p1.cash > p2.cash
        })
        return sortedByMostCoins
    }
}
