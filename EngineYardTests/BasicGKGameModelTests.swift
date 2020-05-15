//
//  BasicGKGameModelTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 15/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest
import GameplayKit

@testable import EngineYard

class BasicGKGameModelTests: XCTestCase {

    private var gameModel: GKGameModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        self.gameModel = GameModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDidCreateGameModel() {
        XCTAssertNotNil(self.gameModel)
    }

}
