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
        let green = self.allLocos!.filter{ return $0.color == .green }
        let red = self.allLocos!.filter{ return $0.color == .red }
        let yellow = self.allLocos!.filter{ return $0.color == .yellow }
        let blue = self.allLocos!.filter{ return $0.color == .blue }
        
        XCTAssertEqual(green.count, Constants.Green.totalGenerations)
        XCTAssertEqual(red.count, Constants.Red.totalGenerations)
        XCTAssertEqual(yellow.count, Constants.Yellow.totalGenerations)
        XCTAssertEqual(blue.count, Constants.Blue.totalGenerations)
    }
}
