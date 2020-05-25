//
//  PlayerViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 25/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// Lets the player select a player
// Used for rapid prototyping
struct PlayerViewModel: Identifiable {
    let id: UUID = UUID()
    let avatar: String
    let name: String
    let cash: Int

    init(name: String, cash: Int = 0, avatar: String) {
        self.name = name
        self.cash = cash
        self.avatar = avatar
    }
}

extension PlayerViewModel {
    // Use generated players for rapid prototyping
    static func create() -> [PlayerViewModel] {
        let players: [PlayerViewModel] = {
            let avatars = [
                PlayerViewModel(name: "Mao", cash: 330, avatar: "avt_1"),
                PlayerViewModel(name: "Lisa", cash: 200, avatar: "avt_2"),
                PlayerViewModel(name: "Ronaldo", cash: 99, avatar: "avt_3"),
                PlayerViewModel(name: "Che", cash: 1, avatar: "avt_4"),
                PlayerViewModel(name: "Sarah", cash: 329, avatar: "avt_5")
            ]
            return avatars
        }()
        return players
    }
}
