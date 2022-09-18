//
//  CardSetupTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 28/05/2022.
//

import XCTest
@testable import EngineYard

// Test the setup of cards

class CardSetupTests: XCTestCase {

    var cards: [Card]?
        
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let board = Board()
        self.cards = board.makeCards()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTotalCards() throws {
        XCTAssertTrue(cards!.count == Constants.totalCards)
    }
    
    func testTotalGreenCards() throws {
        let filtered = cards!.filter {
            $0.livery == .green
        }.count
        XCTAssertTrue(filtered == Constants.Green.totalCards)
    }
    
    func testTotalRedCards() throws {
        let filtered = cards!.filter {
            $0.livery == .red
        }.count
        XCTAssertTrue(filtered == Constants.Red.totalCards)
    }
    
    func testTotalYellowCards() throws {
        let filtered = cards!.filter {
            $0.livery == .yellow
        }.count
        XCTAssertTrue(filtered == Constants.Yellow.totalCards)
    }
    
    func testTotalBlueCards() throws {
        let filtered = cards!.filter {
            $0.livery == .blue
        }.count
        XCTAssertEqual(filtered, Constants.Blue.totalCards)
    }
    
    // Testing generation count
    
    func testGreenGenerationsCount() throws {
        
    }
    
    func testRedGenerationsCount() throws {
        
    }
    
    func testYellowGenerationsCount() throws {
        
    }
    
    func testBlueGenerationsCount() throws {
        
    }
}
