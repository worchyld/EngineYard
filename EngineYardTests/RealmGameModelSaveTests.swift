//
//  RealmGameModelSaveTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 15/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest
import RealmSwift
import GameplayKit

@testable import EngineYard

// Tests to try to see if we can create a GKGameModel, save it to realm and restore it

class RealmGameModelSaveTests: XCTestCase {

    let inMemoryIdentifier: String = "Yard"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = inMemoryIdentifier
        print("[REALM]: \(Realm.Configuration.defaultConfiguration.description)")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }

    func testRealmHasMemoryIdentifier() {
        let config = Realm.Configuration.defaultConfiguration
        XCTAssertTrue(config.inMemoryIdentifier == inMemoryIdentifier)
    }

    func testRealmDoesConnect() {
        do {
            let realm = try Realm()
            XCTAssertNotNil(realm)
        }
        catch {
            XCTFail("Realm connection Error - \(error.localizedDescription)")
        }
    }

    func testRealmHasNoRecords() {
        let realm = try! Realm()
        XCTAssertTrue(realm.isEmpty, "Realm is not empty")
        let gameModelResults = realm.objects(GameModelEntity.self) // retrieves all GameModels from the default Realm
        XCTAssertTrue(gameModelResults.count == 0)
        let gameModelPlayerResults = realm.objects(PlayerEntity.self) // retrieves all Players from the default Realm
        XCTAssertTrue(gameModelPlayerResults.count == 0)
    }

    func testDidSaveGameModel() {
        let players = [ Player.init(), Player.init(),Player.init() ]
        let gameModel = GameModel()
        gameModel.players = players
        guard let gameModelPlayers = gameModel.players else {
            XCTFail("There are no players defined")
            return
        }

        let realm = try! Realm()
        let gameModelEntity = GameModelEntity()
        gameModelEntity.name = "RealmSaveState"

        for (_, player) in gameModelPlayers.enumerated() {
            let playerEntity = PlayerEntity()
            playerEntity.playerId = player.playerId
            playerEntity.state = 0

            gameModelEntity.players.append(playerEntity)
        }

        try! realm.write {
            realm.add(gameModelEntity, update: .modified)
        }

        let results = realm.objects(GameModelEntity.self) // retrieves all GameModels from the default Realm
        XCTAssertTrue(results.count == 1, "Records found: \(results.count)")
    }

}

