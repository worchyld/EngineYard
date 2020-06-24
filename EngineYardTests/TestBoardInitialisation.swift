//
//  TestBoardInitialisation.swift
//  EngineYardTests
//
//  Created by Amarjit on 24/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TestBoardInitialisation: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testDid_LoadJSONFromBundle() throws {

        let trainGame = TrainGame()

        do {
            let result = try trainGame.loadInitialBoard()

            XCTAssertNotNil(result)
        } catch  {
            XCTFail(error.localizedDescription)
        }

    }

    func testDid_InitBoard() throws {
        
    }

}
