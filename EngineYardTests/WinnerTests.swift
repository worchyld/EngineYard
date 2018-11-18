//
//  WinnerTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 18/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class WinnerTests: EngineYardTests {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWinner() {
        var players = Mock.players(howMany: 5)

        guard let game:Game = Game.setup(with: players) else {
            XCTFail("Game object did not initialise")
            return
        }
        guard let _ = game.board else {
            XCTFail("Board object not initialised")
            return
        }

        // Mock add cash
        let _ = players.map({
            let value: Int = Int.randomInt(withMax: 50)
            let amount = (330 + value)

            do {
                try $0.wallet.credit(amount: amount)
            } catch let error {
                print (error.localizedDescription as String)
            }
        })

        players = Player.sortByHighestCash(players)

        guard let firstPlayer = players.first else {
            return
        }

        print ("Winner is: \(String(describing: firstPlayer.name)) with: $\(firstPlayer.cash)")

        players.forEach { (p: Player) in
            if (p != firstPlayer) {
                XCTAssertGreaterThan(firstPlayer.cash, p.cash)
            }
        }
    }

    func testEndConditionMet() {
        let cash = [0,299,300,329,330,331]

        let filtered = cash.filter({
            return (Rules.isGameEndConditionMet($0))
        })

        XCTAssertTrue(filtered.count == 2)
    }

}
