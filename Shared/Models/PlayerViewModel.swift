//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 06/11/2020.
//

import Foundation

struct PlayerViewModel: Equatable, Identifiable, Hashable {
    let id: UUID
    let avatar: String
    let cash: Int
    let trains: Int
    let active: Bool
}
