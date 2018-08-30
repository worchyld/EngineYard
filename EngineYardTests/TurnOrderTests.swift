//
//  TurnOrderTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 29/08/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TurnOrderTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTurnOrder() {
        let players = Mock.players(howMany: 5)
        TurnOrderManager.instance.turnOrder = players

        XCTAssertTrue(TurnOrderManager.instance.turnOrder.count == 5)

        print (TurnOrderManager.instance.currentPlayer)

        TurnOrderManager.instance.next()

        print (TurnOrderManager.currentPlayer)


    }
}
