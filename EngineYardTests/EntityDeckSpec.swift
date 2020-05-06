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

            describe("attempting saving deck to realm") {
                it("saves single deck correctly") {
                    let deck = Deck.init(name: "Deck #1", cost: 4, generation: .first, color: .green, capacity: 4, numberOfChildren: 4)

                    DeckEntity.save(deck: deck, completion: nil)

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
                    expect(deckFromDatabase.cards.count) == 0
                }
            }
        }


        /**
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
                guard let firstDeck = board.decks.first else {
                    XCTFail("Cant find first deck")
                    return
                }

                // Attempt save board into realm
                for deck in board.decks {
                    let deckEntity = DeckEntity.init(with: deck)
                    DeckEntity.save(entity: deckEntity)
                }

                let _ = DeckEntity.find(deck: firstDeck)

            }
        }
        */
    }
}
