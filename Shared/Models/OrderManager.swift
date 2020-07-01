//
//  OrderManager.swift
//  EngineYard
//
//  Created by Amarjit on 01/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class OrderManager : Rollable {
    private var train: Train

    init(train: Train) {
        self.train = train
    }

    internal func roll() -> Int {
        return Die.roll
    }
}

extension OrderManager {
    func addInitialOrder() throws {
        guard (self.train.available) else {
            throw TrainError(reason: .unavailable)
        }
        guard (self.train.rust == .rusted) else {
            throw TrainError(reason: .rusted)
        }
        guard (self.train.rust == .rusting) else {
            throw TrainError(reason: .rusting)
        }
        guard (self.train.initialOrder == nil) else {
            throw TrainError(reason: .alreadyHasInitialOrder)
        }
        train.initialOrder = self.roll()
    }
}
