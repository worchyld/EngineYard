//
//  GameStateTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 19/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest
import GameplayKit

@testable import EngineYard

class GameStateTests: EngineYardTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGameStateInitialised() {
        let machine : GKStateMachine = StateMachine.prepare()

        // Try entering various states...
        if machine.canEnterState(PhaseOne.self) {
            if machine.enter(PhaseOne.self) == false {
                print("failed to move to phase one")
            }
        }
        XCTAssertTrue(machine.canEnterState(PhaseOne.self))
        XCTAssertTrue(machine.canEnterState(PhaseTwo.self))
        XCTAssertFalse(machine.canEnterState(PhaseThree.self))        

        print ("state: \(String(describing: machine.currentState))")

    }
    
}
