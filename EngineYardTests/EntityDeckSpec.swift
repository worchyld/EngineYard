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

// [REALM] Testing `Deck` entity in-memory saving

/*
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


                let board = Board()
                let realm = try! Realm()
                

                for deck in board.decks {
                    let deckObj = DeckEntity.init(with: deck)

                    deckObj.save { (completed: Bool) in
                        if (completed) {
                            for card in deck.cards {
                                let cardObj = CardEntity.init(with: card)

                                try! realm.write {
                                    realm.add(cardObj)
                                    cardObj.parentDeck = deckObj
                                    deckObj.cards.append(cardObj)
                                }
                            }

                        }
                    }
                }

                print ("REALM DECKS")
                let decks = DeckEntity.allRecords()
                expect(decks.count) == Meta.totalDecks

                var counter = CardCounter()
                 var totalCards: Int = 0

                for deck: DeckEntity in decks {
                    print (deck.debugDescription)
                    expect(deck.cards.count) == deck.numberOfChildren
                    XCTAssertTrue(deck.cost % 4 == 0)
                    XCTAssertTrue(deck.orders.count == 0)

                    totalCards += deck.cards.count

                    for _ in deck.cards {
                        guard let colorRef = Deck.Color.init(rawValue: deck.color) else {
                            fail("No color defined")
                            return
                        }

                        counter.increment(with: colorRef)
                    }
                }

                expect(totalCards) == CardCounter.Expected.totalCards
                expect(counter.red) == CardCounter.Expected.red
                expect(counter.green) == CardCounter.Expected.green
                expect(counter.yellow) == CardCounter.Expected.yellow
                expect(counter.blue) == CardCounter.Expected.blue

                // ---------------------

                print ("\n-----")
                print ("REALM CARDS")
                let cards = realm.objects(CardEntity.self)
                expect(cards.count) == Meta.totalCards

                for card: CardEntity in cards {
                    print (card.debugDescription)

                    expect(card.units) == 0
                    expect(card.spentUnits) == 0
                }
            }
        }

    }
}
*/

/*
 DispatchQueue(label: "background").async {
     autoreleasepool {
         let realm = try! Realm()

         realm.beginWrite()
         realm.add(entity)

         try! realm.commitWrite()
     }
 }
 */
