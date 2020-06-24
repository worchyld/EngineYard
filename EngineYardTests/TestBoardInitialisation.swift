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

        trainGame.loadJSON(from: Constants.boardJSONFile, completion: { (response) in
            switch (response) {
            case .success(let response):
                print (response)

                XCTAssertNotNil(response)

            case .failure(let error):
                print (error)
                XCTFail(error.localizedDescription)
            }
        })
    }

    func testDid_InitBoard() throws {
        //let trainGame = TrainGame()
        //try trainGame.start()
    }

}
