//
//  Wallet.swift
//  EngineYard
//
//  Created by Amarjit on 14/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

/** Wallet is an interface/interactor for a player's cash **/

final class Wallet {
    private(set) var cash: Int

    init(_ cash: Int = 0) {
        self.cash = cash
    }
}
