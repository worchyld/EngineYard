//
//  EntityGameSpec.swift
//  EngineYardTests
//
//  Created by Amarjit on 08/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import XCTest
import RealmSwift
import Quick
import Nimble

@testable import EngineYard

// Tests to save/load game entity

/*
class EntityGameSpec: BaseSpec {

    private var game: GameModel?

    override func spec() {
        super.spec()



        describe("Save model") {
          context("Saving to realm", closure: {
            beforeEach {
                self.setupGame()
            }

            let realm = try! Realm()

            it("Saving game model to realm", closure: {
                guard let game = self.game else {
                    fail("No game object created")
                    return
                }

                let records = realm.objects(GameEntity.self)
                if (records.count == 0) {
                    let entity = GameEntity.init()
                    entity.activePlayer = game.activePlayer?.playerId ?? 0
                    entity.gamePhase = game.phase?.rawValue ?? 0
                    entity.hasMusic = game.music
                    entity.hasSound = game.sound
                    entity.turnOrderIndex = game.turnOrderIndex

                    realm.beginWrite()
                    realm.add(entity, update: .modified)
                    try! realm.commitWrite()
                }
            })

            it("Found records", closure: {
                let records = realm.objects(GameEntity.self)
                expect(records.count) == 1

                print (records)
            })

            it("Updated record", closure: {
                guard let firstRecord = realm.objects(GameEntity.self).first else {
                    fail("record not found")
                    return
                }
                try! realm.write {
                    firstRecord.hasMusic = false
                }
            })

            it("music is false", closure: {
                let records = realm.objects(GameEntity.self)
                guard let firstRecord = records.first else {
                    fail("record not found")
                    return
                }

                print (records)

                expect(records.count) == 1
                expect(firstRecord.hasMusic) == false
            })

            afterEach {
            }
          })
        }
    }

    private func setupGame() {
        self.game = GameModel()

        guard let _ = Mock.players(howMany: 3) else {
            fail("No players created")
            return
        }

        guard let mockPlayers: [Player] = SetupManager.createPlayers(howMany: 3) else {
            fail("Invalid player creation")
            return
        }

        XCTAssert(mockPlayers.count == 3)

        guard let game = SetupManager.instance.setup(players: mockPlayers) else {
            fail("No game object")
            return
        }
        XCTAssertNotNil(game)
        XCTAssertNotNil(game.players)
    }


}
*/
