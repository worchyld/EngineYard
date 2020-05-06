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

            describe("attempt to find deck entity in realm") {
                it ("found deck entity in realm") {
                    let deck = Deck.init(name: "Deck #1", cost: 4, generation: .first, color: .green, capacity: 4, numberOfChildren: 4)

                    DeckEntity.save(deck: deck, completion: nil)

                    let realm = try! Realm()
                    let predicate = NSPredicate(format: "cost = %d", 4)
                    let results = realm.objects(DeckEntity.self).filter(predicate)

                    expect(results.count) == 1

                    guard let firstResult: DeckEntity = results.first else {
                        fail("No first result found")
                        return
                    }

                    expect(firstResult.name) == deck.name
                    expect(firstResult.state) == deck.state.rawValue
                    expect(firstResult.generation) == deck.generation.rawValue
                    expect(firstResult.color) == deck.color.rawValue
                    expect(firstResult.cost) == deck.cost
                    expect(firstResult.capacity) == deck.capacity
                    expect(firstResult.numberOfChildren) == deck.numberOfChildren
                    expect(firstResult.cards.count) == 0
                }
            }
        }


        // Attempt to do bulk-save from memory -> realm

        describe("attempting saving board") {
            it ("saving board correctly") {


            }
        }

    }
}
