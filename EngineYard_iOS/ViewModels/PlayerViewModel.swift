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
    static func create() -> [PlayerViewModel] {
        let players: [PlayerViewModel] = {
            let avatars = [
                PlayerViewModel(name: "Mao", avatar: "avt_1"),
                PlayerViewModel(name: "Lisa", avatar: "avt_2"),
                PlayerViewModel(name: "Ronaldo", avatar: "avt_3"),
                PlayerViewModel(name: "Che", avatar: "avt_4"),
                PlayerViewModel(name: "Sarah", avatar: "avt_5"),
            ]
            return avatars
        }()
        return players
    }
}
