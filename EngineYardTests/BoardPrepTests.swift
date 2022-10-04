//
//  BoardPrepTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 18/09/2022.
//

import XCTest

@testable import EngineYard

// Test board preperation

final class BoardPrepTests: XCTestCase {

    var board: Board?
    
    override func setUpWithError() throws {
        self.board = Board()
        self.board!.prepare()
    }

    func testLocoCount() throws {
        XCTAssertTrue(self.board!.locos.count == Constants.totalDecks)
    }
    
    func testDecksCount() throws {
        XCTAssertTrue(self.board!.decks.count == Constants.totalDecks)
    }
        
    func testLocoCostsAreModularOf4() throws {
        let locos = self.board!.locos
        let _ = locos.map { loco in
            XCTAssertTrue(loco.cost % 4 == 0)
        }
    }
    
    func testLocoTrainPoolSumIs50() throws {
        let locos = self.board!.locos
        var sum = 0
        let _ = locos.map { loco in
            sum += loco.trainPool
        }
        XCTAssertTrue(sum == Constants.trainPoolMax)
    }
    
    func testExpectedNumberOfGenerations() throws {
        let locos = self.board!.locos
        let greenLocos = locos.filter {
            return $0.livery == .green
        }
        let redLocos = locos.filter {
            return $0.livery == .red
        }
        let yellowLocos = locos.filter {
            return $0.livery == .yellow
        }
        let blueLocos = locos.filter {
            return $0.livery == .blue
        }
        
        XCTAssertTrue(greenLocos.count == Constants.Green.generations)
        XCTAssertTrue(redLocos.count == Constants.Red.generations)
        XCTAssertTrue(yellowLocos.count == Constants.Yellow.generations)
        XCTAssertTrue(blueLocos.count == Constants.Blue.generations)
    }
    
}
