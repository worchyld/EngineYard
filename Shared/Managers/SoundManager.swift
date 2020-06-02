//
//  SoundManager.swift
//  EngineYard
//
//  Created by Amarjit on 08/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import AVFoundation
import AudioToolbox

enum EYSounds: String {
    case click = "Birdy_Note5.wav"
    case peakClear = "Birdy_Notification1.wav"
    case cardOpen = "cardSlide8.wav"
    case cardSlide = "cardSlide1.wav"

    static let allValues:[EYSounds] = [
        .click, .peakClear, .cardOpen, .cardSlide
    ]
}

final class SoundManager {
    // **must** define instance variable outside, because .play() will deallocate AVAudioPlayer
    // immediately and you won't hear a thing
    private var player: AVAudioPlayer?

    static var manager: SoundManager = SoundManager()

    func playSound(_ sound: EYSounds) {

    }

    func preloadSounds() {
        //for _ in EYSounds.allValues {
            //let _ = manager?.preloadEffect(sound.rawValue)
        //}
    }
}
