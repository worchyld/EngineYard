//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 26/01/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

protocol ProductionProtocol {
    func setInitialProduction()
}

// Each card has a production 
class Production : ProductionProtocol {
    public fileprivate (set) var subscribers: [ProductionProtocol] = []

    public private (set) var units: Int = 0
}

extension Production {
    func setInitialProduction() {
        self.units = 1
        self.removeSubscribers()
    }
}

extension Production {
    func addSubscriber(_ subscriber: ProductionProtocol) {
        self.subscribers.append(subscriber)
    }

    func notifySubscribers() {
        let _ = self.subscribers.map({
            $0.setInitialProduction()
        })
    }

    func removeSubscribers() {
        self.subscribers.removeAll()
    }
}
