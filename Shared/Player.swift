//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 15/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class Player : NSObject {
    var cash : Int {
        return self.wallet.balance
    }
    var wallet : Wallet = Wallet()
}
