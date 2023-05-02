//
//  PlayerViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 02/05/2023.
//

import Foundation

struct PlayerViewModel: Equatable, Identifiable {
    let id: UUID
    let avatar: String
    let cash: Int
    let trains: Int
    let active: Bool
    let hand: [Card]?
    
    init(id: UUID, avatar: String, cash: Int, trains: Int, active: Bool, hand: [Card]?) {
        self.id = id
        self.avatar = avatar
        self.cash = cash
        self.trains = trains
        self.active = active
        self.hand = hand
    }
}
