//
//  GameSetting.swift
//  EngineYard
//
//  Created by Amarjit on 22/10/2022.
//

import Foundation

struct GameSetting : Codable {
    let sfx: Bool
    let music: Bool
    
    init(sfx: Bool = true, music: Bool = false) {
        self.sfx = sfx
        self.music = music
    }
    
    enum Change {
        case sfx(on: Bool)
        case music(on: Bool)
    }
    
    func execute(_ change: Change) -> Self {
        switch change {
        case .sfx(let on):
            return .init(sfx: on, music: music)
        case .music(let on):
            return .init(sfx: sfx, music: on)
        }
    }
}

extension GameSetting {
    func save() {
        
    }
    
    func load() {
        
    }
}
