//
//  CDFilledJSONTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 04/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest
import CoreData

@testable import EngineYard

class CDFilledJSONTests: EngineYardTests {

    var response: Response!
    private var persistenceManager = PersistenceManager()
    private lazy var inMemoryPersistentContainer: NSPersistentContainer = {
        self.persistenceManager.inMemoryPersistentContainer
    }()
    private lazy var inMemoryContext: NSManagedObjectContext = {
        self.persistenceManager.inMemoryContext
    }()

    override func setUp() {
        self.persistenceManager = PersistenceManager()
    }

    func flushData() throws {
        try FactoryEntity.flushAll(in: inMemoryContext)
    }


    override func setUpWithError() throws {
        self.persistenceManager = PersistenceManager()

        // Load JSON From Bundle
        let bundle = Bundle(for: type(of: self))
        let file = Constants.boardJSONFile
        let api = DataLoader.shared
        let result = api.load(from: bundle, file: file)

        switch result {
        case .success(let response):
            self.response = response

        case .failure(let error):
            throw(error)
        }
    }

    override func tearDownWithError() throws {
        try self.flushData()
    }

    func translateJSONToCoreData() throws {
        // create factories
        guard let factories = response.factories else {
            XCTFail("No factories found in JSON")
            return
        }

        let context = self.inMemoryContext
        for factory in factories {
            let factoryEntity: FactoryEntity = NSEntityDescription.insertNewObject(forEntityName: "FactoryEntity" , into: context) as! FactoryEntity
            factoryEntity.name = factory.name
            factoryEntity.avatar = factory.avatar
            factoryEntity.cost = Int16(factory.cost)
            factoryEntity.generation = Int16(factory.generation.rawValue)
            factoryEntity.livery = Int16(factory.livery.rawValue)
            factoryEntity.maxDice = Int16(factory.maxDice)
            factoryEntity.trainPool = Int16(factory.trainPool)
            factoryEntity.rust = Int16(factory.rust.rawValue)

            if let hasInitialOrder = factory.initialOrder {
                let initialOrderEntity = NSEntityDescription.insertNewObject(forEntityName: "OrderEntity", into: context) as! OrderEntity
                initialOrderEntity.value = Int16(hasInitialOrder)
                initialOrderEntity.orderType = Int16(OrderType.initialOrder.rawValue)

                factoryEntity.addToOrders(initialOrderEntity)
            }

            if let hasExistingOrders = factory.existingOrders {
                hasExistingOrders.forEach { (value) in
                    let existingOrderEntity = NSEntityDescription.insertNewObject(forEntityName: "OrderEntity", into: context) as! OrderEntity
                    existingOrderEntity.value = Int16(value)
                    existingOrderEntity.orderType = Int16(OrderType.existingOrder.rawValue)

                    factoryEntity.addToOrders(existingOrderEntity)
                }
            }
            if let hasCompletedOrders = factory.completedOrders {
                hasCompletedOrders.forEach { (value) in
                    let completedOrderEntity = NSEntityDescription.insertNewObject(forEntityName: "OrderEntity", into: context) as! OrderEntity
                    completedOrderEntity.value = Int16(value)
                    completedOrderEntity.orderType = Int16(OrderType.completedOrder.rawValue)

                    factoryEntity.addToOrders(completedOrderEntity)
                }
            }
            if let hasCards = factory.cards {
                hasCards.forEach { (card) in
                    let cardEntity = NSEntityDescription.insertNewObject(forEntityName: "CardEntity", into: context) as! CardEntity
                    cardEntity.name = card.name
                    cardEntity.cost = Int16(card.cost)
                    cardEntity.factory = factoryEntity
                    cardEntity.generation = Int16(card.generation.rawValue)
                    cardEntity.livery = Int16(card.livery.rawValue)
                    cardEntity.production = Int16(card.production)
                    cardEntity.spentProduction = Int16(card.spentProduction)
                    cardEntity.avatar = card.avatar

                    factoryEntity.addToCards(cardEntity)
                }
            }
        }

        // Save context
        try context.save()

        // Load from core data
        performTest {
            do {
                let fetchRequest: NSFetchRequest<FactoryEntity> = FactoryEntity.fetchRequest()

                let results = try context.fetch(fetchRequest)
                XCTAssertEqual(results.count, response.factories?.count)

                guard let firstObj = results.first else {
                    XCTFail("No object found")
                    return
                }

                print (firstObj)

            }
            catch {
                throw error
            }
        }
    }

}
