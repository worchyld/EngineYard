//
//  EntityDeckSpec.swift
//  EngineYardTests
//
//  Created by Amarjit on 18/04/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import RealmSwift
import XCTest
import Quick
import Nimble

@testable import EngineYard

// [REALM] Testing `Deck` entity

class EntityDeckSpec: BaseSpec {

    override func spec() {
        super.spec()

        describe("models") {

            describe("initialize with name and age") {
                it("initializes correctly") {
                    let deck = Deck.init(name: "Deck #1", cost: 4, generation: .first, color: .green, capacity: 4, numberOfChildren: 4)
                    let deckEntity = DeckEntity.init(with: deck)

                    expect(deckEntity.name) == deck.name
                    expect(deckEntity.state) == deck.state.rawValue
                    expect(deckEntity.generation) == deck.generation.rawValue
                    expect(deckEntity.color) == deck.color.rawValue
                    expect(deckEntity.cost) == deck.cost
                    expect(deckEntity.capacity) == deck.capacity
                    expect(deckEntity.numberOfChildren) == deck.numberOfChildren
                }
            }

            describe("attempting saving deck") {
                it("saves single deck correctly") {
                    let deck = Deck.init(name: "Deck #1", cost: 4, generation: .first, color: .green, capacity: 4, numberOfChildren: 4)
                    let deckEntity = DeckEntity.init(with: deck)

                    deckEntity.save()
                    let realm = try! Realm()

                    guard let deckFromDatabase = realm.objects(DeckEntity.self).last else {
                        fail("No deck from database found")
                        return
                    }

                    expect(deckFromDatabase.name) == deck.name
                    expect(deckFromDatabase.state) == deck.state.rawValue
                    expect(deckFromDatabase.generation) == deck.generation.rawValue
                    expect(deckFromDatabase.color) == deck.color.rawValue
                    expect(deckFromDatabase.cost) == deck.cost
                    expect(deckFromDatabase.capacity) == deck.capacity
                    expect(deckFromDatabase.numberOfChildren) == deck.numberOfChildren
                }
            }
        }

        describe("attempting saving board") {
            it ("saving board correctly") {
                let playerCount = 5

                guard let _ = Mock.players(howMany: playerCount) else {
                    fail("No players created")
                    return
                }
                guard let mockPlayers: [Player] = SetupManager.createPlayers(howMany: playerCount) else {
                    fail("Invalid player creation")
                    return
                }
                guard let game = SetupManager.instance.setup(players: mockPlayers) else {
                    fail("no game")
                    return
                }
                guard let board = game.board else {
                    XCTFail("No board found")
                    return
                }

                // Save board into realm
                let realm = try! Realm()
                for deck in board.decks {
                    let deckEntity = DeckEntity.init(with: deck)
                    deckEntity.save()

                    for card in deck.cards {
                        
                    }
                }

            }
        }
    }
}
