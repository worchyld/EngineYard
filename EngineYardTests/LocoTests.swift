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
    
    func testExpectedCardCount() throws {
        let expected = Constants.Trains.totalCards
        
        let sum = allLocos.map { loco in
            return loco.trainPool
        }.reduce(0, +)
        
        XCTAssertEqual(sum, expected)
    }

    func testDicePoolCapacity() throws {
        let expected = Constants.Trains.totalDicePoolCapacity
        let sum = allLocos.map { loco in
            return loco.dicePoolCapacity
        }.reduce(0, +)
        XCTAssertEqual(sum, expected, "Sum does not equal expected \(sum)")
    }
    
    func testLocoCostsAreModularOf4() throws {
        let _ = allLocos.map { loco in
            XCTAssertTrue(loco.cost % 4 == 0)
        }
    }
    
    func testLocoGenerationCount() throws {
        let green = self.allLocos.filter{ return $0.colour == .green }
        let red = self.allLocos.filter{ return $0.colour == .red }
        let yellow = self.allLocos.filter{ return $0.colour == .yellow }
        let blue = self.allLocos.filter{ return $0.colour == .blue }
        
        XCTAssertEqual(green.count, Constants.Green.totalGenerations)
        XCTAssertEqual(red.count, Constants.Red.totalGenerations)
        XCTAssertEqual(yellow.count, Constants.Yellow.totalGenerations)
        XCTAssertEqual(blue.count, Constants.Blue.totalGenerations)
    }
    
    func testDicePool() throws {
        let green = self.allLocos.filter{ return $0.colour == .green }
        let red = self.allLocos.filter{ return $0.colour == .red }
        let yellow = self.allLocos.filter{ return $0.colour == .yellow }
        let blue = self.allLocos.filter{ return $0.colour == .blue }
        
        let greenTrainPoolSum = green.map { loco in
            return loco.trainPool
        }.reduce(0, +)
        let redTrainPoolSum = red.map { loco in
            return loco.trainPool
        }.reduce(0, +)
        let yellowTrainPoolSum = yellow.map { loco in
            return loco.trainPool
        }.reduce(0, +)
        let blueTrainPoolSum = blue.map { loco in
            return loco.trainPool
        }.reduce(0, +)
        
        XCTAssertEqual(greenTrainPoolSum, Constants.Green.totalCards)
        XCTAssertEqual(redTrainPoolSum, Constants.Red.totalCards)
        XCTAssertEqual(yellowTrainPoolSum, Constants.Yellow.totalCards)
        XCTAssertEqual(blueTrainPoolSum, Constants.Blue.totalCards)
        
        let greenDicePoolSum = green.map { loco in
            return loco.dicePoolCapacity
        }.reduce(0, +)
        let redDicePoolSum = red.map { loco in
            return loco.dicePoolCapacity
        }.reduce(0, +)
        let yellowDicePoolSum = yellow.map { loco in
            return loco.dicePoolCapacity
        }.reduce(0, +)
        let blueDicePoolSum = blue.map { loco in
            return loco.dicePoolCapacity
        }.reduce(0, +)

        let sum = (greenDicePoolSum + redDicePoolSum + yellowDicePoolSum + blueDicePoolSum)
        
        XCTAssertEqual(greenDicePoolSum, Constants.Green.totalDiceCapacity)
        XCTAssertEqual(redDicePoolSum, Constants.Red.totalDiceCapacity)
        XCTAssertEqual(yellowDicePoolSum, Constants.Yellow.totalDiceCapacity)
        XCTAssertEqual(blueDicePoolSum, Constants.Blue.totalDiceCapacity)
        
        XCTAssertEqual(sum, Constants.Trains.totalDicePoolCapacity)
    }
    

}
