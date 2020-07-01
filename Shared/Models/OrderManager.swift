//
//  OrderManager.swift
//  EngineYard
//
//  Created by Amarjit on 01/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

enum OrderType : Int {
    case initialOrder
    case existingOrder
    case completedOrder
}

class OrderManager : Rollable {
    private var train: Train

    init(train: Train) {
        self.train = train
    }
}


extension OrderManager {
    internal func roll() -> Int {
        return Die.roll
    }

    internal func validate(train: Train) throws {
        guard (self.train.available) else {
            throw TrainError(reason: .unavailable)
        }
        guard (self.train.rust == .rusted) else {
            throw TrainError(reason: .rusted)
        }
        guard (self.train.rust == .rusting) else {
            throw TrainError(reason: .rusting)
        }
    }

    internal func hasSpaceForOrders(train: Train)  throws -> Bool {
        guard (self.train.countOrders < self.train.maxDice) else {
            throw TrainError(reason: .ordersAreFull)
        }
        return true
    }
}


extension OrderManager {
    func add(orderType: OrderType) throws {
        do {
            switch orderType {
            case .initialOrder:
                try addInitialOrder()
            case .existingOrder:
                try addExistingOrder()
            case .completedOrder:
                try addCompletedOrder()
            }
        }
        catch {
            throw error
        }
    }
}

extension OrderManager {
    func addInitialOrder() throws {
        do {
            try validate(train: self.train)
            guard (self.train.initialOrder == nil) else {
                throw TrainError(reason: .alreadyHasInitialOrder)
            }
            train.initialOrder = self.roll()
        }
        catch {
            throw error
        }
    }
}

extension OrderManager {
    func addExistingOrder() throws {
        do {
            try validate(train: self.train)
            if let _ = train.initialOrder {
                throw TrainError(reason: .alreadyHasInitialOrder)
            }
            if try self.hasSpaceForOrders(train: self.train) {
                train.existingOrders?.append( roll() )
            }
        }
        catch {
            throw error
        }
    }
}

extension OrderManager {
    func addCompletedOrder() throws {
        do {
            try validate(train: self.train)
            guard var completedOrders = self.train.completedOrders else {
                throw TrainError(reason: .noCompletedOrders)
            }

            if try self.hasSpaceForOrders(train: train) {
                completedOrders.append( self.roll() )
            }

        } catch {
            throw error
        }
    }
}
