//
//  TranslateObjectsToCoreData.swift
//  EngineYard
//
//  Created by Amarjit on 13/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import CoreData

// Translate objects -> core data
class TranslateObjectsToCoreData {
    func save(board: Board) throws {
        guard !board.isEmpty else {
            throw BoardError(reason: .missing)
        }
        let context = CoreDataManager.shared.context

        for item in board {
            if let factory = item {
                let factoryEntity: FactoryEntity = NSEntityDescription.insertNewObject(forEntityName: "FactoryEntity" , into: context) as! FactoryEntity
                factoryEntity.name = factory.name
                factoryEntity.avatar = factory.avatar
                factoryEntity.cost = Int16(factory.cost)
                factoryEntity.generation = Int16(factory.generation.rawValue)
                factoryEntity.livery = Int16(factory.livery.rawValue)
                factoryEntity.maxDice = Int16(factory.maxDice)
                factoryEntity.trainPool = Int16(factory.trainPool)
                factoryEntity.rust = Int16(factory.rust.rawValue)

                if (factory.existingOrders == nil) {
                    factory.existingOrders = [Int]()
                }
                if (factory.completedOrders == nil) {
                    factory.completedOrders = [Int]()
                }

                if let hasInitialOrder = factory.initialOrder {
                    let initialOrderEntity = OrderEntity.create(in: context, value: hasInitialOrder, orderType: .initialOrder)
                    factoryEntity.addToOrders(initialOrderEntity)
                }

                if let hasExistingOrders = factory.existingOrders {
                    for o in hasExistingOrders {
                        let existingOrderEntity = OrderEntity.create(in: context, value: o, orderType: .existingOrder)
                        factoryEntity.addToOrders(existingOrderEntity)
                    }
                }

                if let hasCompletedOrders = factory.completedOrders {
                    for o in hasCompletedOrders {
                        let completedOrderEntity = OrderEntity.create(in: context, value: o, orderType: .completedOrder)
                        factoryEntity.addToOrders(completedOrderEntity)
                    }
                }
            }

            do {
                try context.save()
            }
            catch {
                if let nserror = error as NSError? {
                    throw nserror
                }
            }
        } // :next

        

    }
}
