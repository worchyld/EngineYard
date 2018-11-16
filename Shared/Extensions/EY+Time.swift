//
//  EY+Time.swift
//  EngineYard
//
//  Created by Amarjit on 16/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

func waitFor(duration: TimeInterval, callback: @escaping (Bool) -> ()) {
    let when = DispatchTime.now() + duration
    DispatchQueue.main.asyncAfter(deadline: when) {
        callback(true)
    }
}
