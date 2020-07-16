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
        //try FactoryEntity.flushAll(in: inMemoryContext)
        try persistenceManager.flushAll(in: inMemoryContext)
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

    func testTranslateJSONToCoreData() throws {
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

            XCTAssertNil(factory.initialOrder)            
            XCTAssertNil(factory.existingOrders)
            XCTAssertNil(factory.completedOrders)

            factory.existingOrders = [Int]()
            factory.completedOrders = [Int]()

            // add initialOrder
            factory.initialOrder = Die.roll
            // add existingOrders
            for _ in 1...3 {
                let value = Die.roll
                factory.existingOrders?.append(value)
            }
            // add completedOrders
            for _ in 1...3 {
                let value = Die.roll
                factory.completedOrders?.append(value)
            }

            // set entity versions
            if let hasInitialOrder = factory.initialOrder {
                let initialOrderEntity = NSEntityDescription.insertNewObject(forEntityName: "OrderEntity", into: context) as! OrderEntity
                initialOrderEntity.value = Int16(hasInitialOrder)
                initialOrderEntity.orderType = Int16(OrderType.initialOrder.rawValue)

                factoryEntity.addToOrders(initialOrderEntity)
            }
            else {
                XCTFail("No initial order found")
            }

            if let hasExistingOrders = factory.existingOrders {
                hasExistingOrders.forEach { (value) in
                    let existingOrderEntity = NSEntityDescription.insertNewObject(forEntityName: "OrderEntity", into: context) as! OrderEntity
                    existingOrderEntity.value = Int16(value)
                    existingOrderEntity.orderType = Int16(OrderType.existingOrder.rawValue)

                    factoryEntity.addToOrders(existingOrderEntity)
                }
            }
            else {
                XCTFail("No existing orders found")
            }


            if let hasCompletedOrders = factory.completedOrders {
                hasCompletedOrders.forEach { (value) in
                    let completedOrderEntity = NSEntityDescription.insertNewObject(forEntityName: "OrderEntity", into: context) as! OrderEntity
                    completedOrderEntity.value = Int16(value)
                    completedOrderEntity.orderType = Int16(OrderType.completedOrder.rawValue)

                    factoryEntity.addToOrders(completedOrderEntity)
                }
            }
            else {
                XCTFail("No completed orders found")
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
            else {
                print ("No cards found")
            }


            // Save context
            try context.save()

        } // :next

        // Load from core data
        performTest {
            do {
                let fetchRequest: NSFetchRequest<FactoryEntity> = FactoryEntity.fetchRequest()

                let results = try context.fetch(fetchRequest) as [FactoryEntity]
                XCTAssertEqual(results.count, response.factories?.count)

                guard let firstObj = results.first else {
                    XCTFail("No object found")
                    return
                }

                print (firstObj)
                print (firstObj.orders as Any)
                XCTAssertNotNil( firstObj.orders )
                XCTAssertEqual(firstObj.orders?.count, 7)
                guard let orders = firstObj.orders else {
                    XCTFail("No orders found")
                    return
                }
                let orderPredicate1 = NSPredicate(format: "orderType == \(OrderType.initialOrder.rawValue)", argumentArray: nil)
                let orderPredicate2 = NSPredicate(format: "orderType == \(OrderType.existingOrder.rawValue)", argumentArray: nil)
                let orderPredicate3 = NSPredicate(format: "orderType == \(OrderType.completedOrder.rawValue)", argumentArray: nil)

                let initialOrders = orders.filtered(using: orderPredicate1)
                let existingOrders = orders.filtered(using: orderPredicate2)
                let completedOrders = orders.filtered(using: orderPredicate3)

                XCTAssertEqual(initialOrders.count, 1)
                XCTAssertEqual(existingOrders.count, 3)
                XCTAssertEqual(completedOrders.count, 3)

            }
            catch {
                throw error
            }
        }

        performTest {
            do {
                let livery = Livery.green.rawValue
                let generation = Generation.first.rawValue
                let predicate = NSPredicate(format: "livery == %@ AND generation == %@", argumentArray: [livery, generation])
                let fetchRequest: NSFetchRequest<FactoryEntity> = FactoryEntity.fetchRequest()
                fetchRequest.predicate = predicate

                let results = try context.fetch(fetchRequest) as [FactoryEntity]
                XCTAssertEqual(results.count, 1)


            }
            catch {
                throw error
            }
        }
    }


    func testDidTranslateToCoreData() throws {
        let context = self.inMemoryContext
        let bundle = Bundle(for: type(of: self))
        let trainGame = TrainGame()
        try trainGame.start(bundle)

        let translater = TranslateObjectsToCoreData.init()
        try translater.save(game: trainGame, in: context)

        let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        let gameEntity = try context.fetch(fetchRequest).first

        if let factories = gameEntity?.factories {
            XCTAssertTrue(factories.count == 14)
            print ("Results -- \(gameEntity as Any)")
        }
        else {
            XCTFail("No factories found in core data")
        }
    }

}
