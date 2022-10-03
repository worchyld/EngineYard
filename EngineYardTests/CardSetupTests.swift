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

    let board = Board()
        
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.board.prepare()
    }
    
    func testTotalCards() throws {
//        XCTAssertTrue(cards!.count == Constants.totalCards)
    }
    
//    func testTotalGreenCards() throws {
//        let filtered = cards!.filter {
//            $0.livery == .green
//        }.count
//        XCTAssertTrue(filtered == Constants.Green.totalCards)
//    }
//
//    func testTotalRedCards() throws {
//        let filtered = cards!.filter {
//            $0.livery == .red
//        }.count
//        XCTAssertTrue(filtered == Constants.Red.totalCards)
//    }
//
//    func testTotalYellowCards() throws {
//        let filtered = cards!.filter {
//            $0.livery == .yellow
//        }.count
//        XCTAssertTrue(filtered == Constants.Yellow.totalCards)
//    }
//
//    func testTotalBlueCards() throws {
//        let filtered = cards!.filter {
//            $0.livery == .blue
//        }.count
//        XCTAssertEqual(filtered, Constants.Blue.totalCards)
//    }
    
}
