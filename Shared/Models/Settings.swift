//
//  GameSettings.swift
//  EngineYard
//
//  Created by Amarjit on 04/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

// #TODO

class SoundManager {
    static var instance: SoundManager = SoundManager()

    let settings: Settings = Settings()

    func play(_ sound: Sounds) {
        guard (settings.sound) else {
            return
        }
        // #TODO
    }

    func preload() {
        /*
        for sound in Sounds.AllCases {
            // Preload effect
        }
        */
    }
}

struct Settings {
    public private (set) var sound: Bool = false
    public private (set) var music: Bool = false
}

extension Settings {
    func load() {

    }

    func save() {

    }

    mutating func toggleSound() {
        self.sound = !self.sound
    }

    mutating func toggleMusic() {
        self.music = !self.music
    }
}
