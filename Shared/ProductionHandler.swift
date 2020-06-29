//
//  ProductionHandler.swift
//  EngineYard
//
//  Created by Amarjit on 28/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class ProductionHandler {

    func reset(production: FactoryProduction) -> FactoryProduction {
        production.units = production.spent
        production.spent = 0
        return production
    }

    func increase(amount: Int, on subject: FactoryProduction, train: TrainDelegate, player: PlayerDelegate) throws -> FactoryProduction {

        let increaser = Increaser.init(subject.units)

        do {
            let increaseOK = try increaser.canIncrease(by: amount)
            let trainRusted = {
                return (train.rusting == .rusted)
            }()
            let trainHasOrders = {
                return (train.hasOrders())
            }()
            let totalCost = (train.productionCost * amount)

            // is total positive?
            guard (totalCost.isPositive) else {
                throw NSError(domain: "The total cost of production is not positive", code: 0, userInfo: nil)
            }

            guard let _ = player.cards.filter({ $0.id == subject.id }).first else {
                throw NSError(domain: "You don't own this card", code: 0, userInfo: nil)
            }

            // enough cash?
            guard player.cash >= totalCost else {
                throw SpendingError.mustBePositive(totalCost)
            }
            // is increaseOK?
            guard (increaseOK) else {
                throw NSError(domain: "The increase is invalid", code: 0, userInfo: nil)
            }

            // has the train been rusted?
            guard (!trainRusted) else {
                throw TrainError.trainHasRusted(train: train)
            }
            // has the train got orders?
            guard (trainHasOrders) else {
                throw TrainError.trainHasNoOrders(train: train)
            }
            // is the train available
            guard (train.available) else {
                throw TrainError.trainIsNotAvailable
            }

            subject.units += amount

            return subject
        }
        catch {
            throw error
        }

    }

    func spend(amount: Int, on subject: FactoryProduction, train: TrainDelegate ) throws -> FactoryProduction {

        let spender = Spender.init(subject.units)

        do {
            let spendOK = try spender.canSpend(amount: amount)
            let trainRusted = {
                return (train.rusting == .rusted)
            }()
            let trainHasOrders = {
                return (train.hasOrders())
            }()
            // can we spend the production?
            guard (spendOK) else {
                throw SpendingError.cannotSpend(amount)
            }
            // has the train been rusted?
            guard (!trainRusted) else {
                throw TrainError.trainHasRusted(train: train)
            }
            // has the train got orders?
            guard (trainHasOrders) else {
                throw TrainError.trainHasNoOrders(train: train)
            }
            // is the train available
            guard (train.available) else {
                throw TrainError.trainIsNotAvailable
            }

            subject.units -= amount
            subject.spent += amount

            return subject
        }
        catch {
            throw error
        }
    }
}
