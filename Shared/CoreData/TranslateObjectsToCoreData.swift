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
    func save(game: TrainGame, in context: NSManagedObjectContext) throws {

        guard !game.board.isEmpty else {
            throw BoardError(reason: .missing)
        }

        // Save board
        for item in game.board {
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
            } // :endif

            do {
                try context.save()
            }
            catch {
                if let nserror = error as NSError? {
                    throw nserror
                }
            }
        } // :next

        

        // Save players
        for player in game.players {
            let playerEntity: PlayerEntity = NSEntityDescription.insertNewObject(forEntityName: "PlayerEntity", into: context) as! PlayerEntity
            playerEntity.name = player.name
            playerEntity.cash = Int16(player.cash)
            playerEntity.avatar = player.avatar
            playerEntity.state = Int16(player.state.rawValue)
            playerEntity.turnOrder = Int16(player.turnOrder)

            for card in player.cards {
                // Find factory object in core data
                let predicate = NSPredicate(format: "livery == %@ AND generation == %@", argumentArray: [card.livery.rawValue, card.generation.rawValue])
                let fetchRequest: NSFetchRequest<FactoryEntity> = FactoryEntity.fetchRequest()
                fetchRequest.predicate = predicate
                fetchRequest.fetchLimit = 1

                let results = try context.fetch(fetchRequest)
                print ("Found results -- \(results)")
                if (results.count == 1) {

                    let factoryEntity: FactoryEntity = results.first!
                    let cardEntity: CardEntity = NSEntityDescription.insertNewObject(forEntityName: "CardEntity", into: context) as! CardEntity
                    cardEntity.avatar = card.avatar
                    cardEntity.name = card.name
                    cardEntity.cost = Int16(card.cost)
                    cardEntity.owner = playerEntity
                    cardEntity.livery = Int16(card.livery.rawValue)
                    cardEntity.generation = Int16(card.generation.rawValue)
                    cardEntity.production = Int16(card.production)
                    cardEntity.spentProduction = Int16(card.spentProduction)
                    cardEntity.factory = factoryEntity
                    cardEntity.owner = playerEntity

                }
                else {
                    print ("Found \(results.count)")
                }

                do {
                    try context.save()
                }
                catch {
                    if let nserror = error as NSError? {
                        throw nserror
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
        }


        // Get player entities
        let playersFetchRequest: NSFetchRequest<PlayerEntity> = PlayerEntity.fetchRequest()
        let playerResults = try context.fetch(playersFetchRequest)

        // Get factory entities
        let factoryFetchRequest: NSFetchRequest<FactoryEntity> = FactoryEntity.fetchRequest()
        let factoryResults = try context.fetch(factoryFetchRequest)

        // Save game entity
        let gameEntity: GameEntity = NSEntityDescription.insertNewObject(forEntityName: "GameEntity", into: context) as! GameEntity
        gameEntity.phase = Int16(game.phase.rawValue)

        for playerEntity in playerResults {
            gameEntity.addToPlayers(playerEntity)
        }
        for factoryEntity in factoryResults {
            gameEntity.addToFactories(factoryEntity)
        }
        do {
            try context.save()
        }
        catch {
            if let nserror = error as NSError? {
                throw nserror
            }
        }
    }

    func load(trainGame: TrainGame) throws -> TrainGame {
        // Get game entity
        let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        fetchRequest.fetchLimit = 1

        let context = CoreDataManager.shared.context
        do {
            if let gameEntity = try context.fetch(fetchRequest).first {
                print ("Game entity -- \(gameEntity as Any)")
            }
        }
        catch {
            throw error
        }

        return trainGame
    }
}
