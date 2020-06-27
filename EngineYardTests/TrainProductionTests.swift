//
//  TrainProductionTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 27/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TrainProductionTests: XCTestCase {

    var trainGame: TrainGame!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle = Bundle(for: type(of: self))

        self.trainGame = TrainGame()
        try trainGame.start(bundle)

        XCTAssertNotNil(trainGame.board)
        guard let _ = trainGame.board else {
            XCTFail("Board doesn't exist")
            return
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    

}
