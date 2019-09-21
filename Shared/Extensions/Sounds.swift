//
//  Sounds.swift
//  EngineYard
//
//  Created by Amarjit on 07/12/2016.
//  Copyright © 2016 Amarjit. All rights reserved.
//

import Foundation

enum EYSounds: String {
    case click = "Birdy_Note5.wav"
    case notify = "Birdy_Notification1.wav"
    case cardOpen = "cardSlide8.wav"
    case cardSlide = "cardSlide1.wav"

    static let allValues:[EYSounds] = [
        .click,
        .notify,
        .cardOpen,
        .cardSlide
    ]

}
