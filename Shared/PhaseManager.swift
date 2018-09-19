//
//  PhaseManager.swift
//  EngineYard
//
//  Created by Amarjit on 19/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

protocol PhaseCompletionProtocol {
    func phaseDidComplete(player: Player)
    func phaseManagerShouldReset()
}

class PhaseManager : PhaseCompletionProtocol {
    private var phase: GKState?
    private var _players: [Player] = [Player]()

    init(with players:[Player], phase: GKState? = nil) {
        self._players = players
        self.phase = phase
    }

    func phaseDidComplete(player: Player) {
        let results = (_players.filter({ (p: Player) -> Bool in
            return (p == player)
        }).count)

        if (results > 0) {
            return
        }
        _players.append(player)
    }

    func phaseManagerShouldReset() {
        self._players.removeAll()
    }

}
