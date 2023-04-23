//
//  LocoTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 23/04/2023.
//

import XCTest
@testable import EngineYard

final class LocoTests: XCTestCase {

    private var allLocos: [Locomotive] = [Locomotive]()
    
    override func setUpWithError() throws {
        self.allLocos = Locomotive.allLocos()
    }

    override func tearDownWithError() throws {
        self.allLocos.removeAll()
    }
    
    func testExpectedDeckCount() throws {
        XCTAssertTrue(allLocos.count == Constants.Trains.total)
    }
    
    func testExpectedCardsCount() throws {
        let expected = Constants.Trains.totalCards
        
    }

    func testDiceCapacity() throws {
        let expected = Constants.Trains.totalDicePoolCapacity
        let current = allLocos.map { loco in
            return loco.capacity
        }.reduce(0, +)
        XCTAssertEqual(current, expected, "Current does not equal expected \(current)")
    }

}
