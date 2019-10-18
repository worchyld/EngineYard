//
//  EngineYardTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 13/04/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest
@testable import EngineYard

public struct Mock {
    public static func players(howMany: Int) -> [Player]? {
        guard Constants.Players.valid(howMany) else {
            return nil
        }
        var players: [Player] = [Player]()
        for index in stride(from:0, to: howMany, by: 1) {
            let player = Player(name: "Player #\(index)", isAI: true)
            players.append(player)
        }
        return players
    }
}

class EngineYardTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
}
