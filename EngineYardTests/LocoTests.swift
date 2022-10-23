//
//  LocoTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 02/10/2022.
//

import XCTest

@testable import EngineYard

final class LocoTests: XCTestCase {

    var allLocos: [Locomotive]?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.allLocos = Locomotive.allLocos()
    }
    
    func testThereAre14Locos() throws {
        let count = self.allLocos!.count
        XCTAssertEqual(count, Constants.totalLocos)
    }
    
    func test43CardsToBeGeneratedFromLocos() throws {
        let sum = self.allLocos!.reduce(0) { partialResult, loco in
            return partialResult + loco.qty
        }
        XCTAssertEqual(sum, Constants.totalCards)
    }
    
    func testCapacityToBeGeneratedFromLocos() throws {
        let sum = self.allLocos!.reduce(0) { partialResult, loco in
            return partialResult + loco.capacity
        }
        XCTAssertEqual(sum, Constants.totalCapacity)
    }
    
    
    func testLocoCostsAreModularOf4() throws {
        let locos = self.allLocos!
        let _ = locos.map { loco in
            XCTAssertTrue(loco.cost % 4 == 0)
        }
    }
    
    func testTotalColors() throws {
        let green = self.allLocos!.filter{ return $0.livery == .green }
        let red = self.allLocos!.filter{ return $0.livery == .red }
        let yellow = self.allLocos!.filter{ return $0.livery == .yellow }
        let blue = self.allLocos!.filter{ return $0.livery == .blue }
        
        XCTAssertEqual(green.count, Constants.Green.totalGenerations)
        XCTAssertEqual(red.count, Constants.Red.totalGenerations)
        XCTAssertEqual(yellow.count, Constants.Yellow.totalGenerations)
        XCTAssertEqual(blue.count, Constants.Blue.totalGenerations)
    }
    
    func testRustify() throws {
        let firstLoco = self.allLocos!.first!
        XCTAssertTrue(firstLoco.rust == .notBuilt)
        firstLoco.rustify()
        XCTAssertTrue(firstLoco.rust == .active)
        firstLoco.rustify()
        XCTAssertTrue(firstLoco.rust == .rusting)
        firstLoco.rustify()
        XCTAssertTrue(firstLoco.rust == .rusted)
        // try to exceed rusted state
        firstLoco.rustify()
        XCTAssertTrue(firstLoco.rust == .rusted)
    }

    
    func testRustAvailability() throws {
        let firstLoco = self.allLocos!.first!
        XCTAssertFalse(firstLoco.isAvailable)
        firstLoco.addOrder(order: Die.roll)
        XCTAssertTrue(firstLoco.isAvailable)
    }
    
    func testAddOrder() throws {
        let firstLoco = self.allLocos!.first!
        XCTAssertFalse(firstLoco.isFull)
        let capacity = firstLoco.capacity
        for _ in 0...(capacity - 1) {
            firstLoco.addOrder(order: Die.roll)
        }
        XCTAssertTrue(firstLoco.orders.count == capacity)
        XCTAssertTrue(firstLoco.isFull)
        let _ = firstLoco.orders.map {
            XCTAssertTrue($0.isD6)
        }
    }
    
    func testAddOrdersBeyondCapacity() throws {
        let firstLoco = self.allLocos!.first!
        XCTAssertFalse(firstLoco.isFull)
        let capacity = firstLoco.capacity
        for _ in 0...(capacity - 1) {
            firstLoco.addOrder(order: Die.roll)
        }
        firstLoco.addOrder(order: Die.roll)
        XCTAssertTrue(firstLoco.orders.count == capacity)
        XCTAssertTrue(firstLoco.isFull)
    }
    
    func testAddSale() throws {
        let firstLoco = self.allLocos!.first!
        XCTAssertFalse(firstLoco.isFull)
        let capacity = firstLoco.capacity
        for _ in 0...(capacity - 1) {
            firstLoco.addSale(order: Die.roll)
        }
        XCTAssertTrue(firstLoco.sales.count == capacity)
        XCTAssertTrue(firstLoco.isFull)
        let _ = firstLoco.sales.map {
            XCTAssertTrue($0.isD6)
        }
        
        // add beyond capacity
        firstLoco.addSale(order: Die.roll)
        XCTAssertTrue(firstLoco.sales.count == capacity)
        XCTAssertTrue(firstLoco.isFull)
    }
    
    
    func testReduceQtyBy1() throws {
        let firstLoco = self.allLocos!.first!
        let expected = (firstLoco.qty - 1)
        firstLoco.reduceQtyBy1()
        XCTAssertTrue(firstLoco.qty == expected)
        XCTAssertTrue(firstLoco.qty >= 0)
    }
    
}
