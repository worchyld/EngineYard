//
//  TestLocalData.swift
//  EngineYardTests
//
//  Created by Amarjit on 24/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TestLocalData: XCTestCase {

    internal var response: Response!
    internal var components: Components!

    struct Components {
        var meta: Meta
        var factories: [Factory]
        var spaces: [Space]
        var locomotives: [Locomotive]

        init( meta: Meta, factories: [Factory], spaces: [Space], locomotives: [Locomotive] ) {
            self.meta = meta
            self.factories = factories
            self.spaces = spaces
            self.locomotives = locomotives
        }
    }


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        let bundle = Bundle(for: type(of: self))
        let api = FixturesLoaderAPI.shared
        let file = Constants.boardJSONFile


        //api.fetchFixtures(from: file) { [weak self] result in

        api.decodeJSON(fromFile: file, in: bundle) { [weak self] result in

            switch result {
            case .success(let response):
                self?.response = response

                guard let meta = response.meta else {
                    XCTFail("No meta found")
                    return
                }

                guard let factories = response.factories else {
                    XCTFail("No factories found")
                    return
                }

                guard let spaces = response.spaces else {
                    XCTFail("No spaces found")
                    return
                }

                guard let locomotives = response.locomotives else {
                    XCTFail("No locomotives found")
                    return
                }

                self?.components = Components(meta: meta, factories: factories, spaces: spaces, locomotives: locomotives)

            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBundle_CannotFindFile() throws {
        let bundle = Bundle(for: type(of: self))
        let api = FixturesLoaderAPI.shared

        // Boards.json should fail
        let file = "boards.json"

        //api.fetchFixtures(from: file) { result in
        api.decodeJSON(fromFile: file, in: bundle) { (result) in

            let expectedError = BundleError.failedToLocate(file)
            print (expectedError)

            self.assert(result, containsError: expectedError)
        }
    }


    func testLoadData_ResponseNotNil() throws {
        XCTAssertNotNil(  self.response )
    }

    func testLocalData_ComponentsNotNil() throws {
        XCTAssertNotNil( self.components )
    }

    func testFactoriesEqualsSpaces() throws {
        let factories = components.factories
        XCTAssertEqual(factories.count, components.meta.spaces)
    }

    func testLocomotivesEqualsCardsQty() throws {
        let locos = components.locomotives
        XCTAssertEqual(locos.count, components.meta.cards.total)
    }

    func testFilterGreenCards() throws {
        let cards = components.locomotives
        let expected = 20
        let green = Card.filter(cards: cards, on: .green)
        XCTAssertEqual(green.count, components.meta.cards.green.total)
        XCTAssertEqual(green.count, expected)
    }

    func testFilterRedCards() throws {
        let cards = components.locomotives
        let expected = 13
        let red = Card.filter(cards: cards, on: .red)
        XCTAssertEqual(red.count, components.meta.cards.red.total)
        XCTAssertEqual(red.count, expected)
    }

    func testFilterYellowCards() throws {
        let cards = components.locomotives
        let expected = 7
        let yellow = Card.filter(cards: cards, on: .yellow)
        print ("yellow cards == \(yellow as Any)")
        XCTAssertEqual(yellow.count, components.meta.cards.yellow.total)
        XCTAssertEqual(yellow.count, expected)
    }

    func testFilterBlueCards() throws {
        let cards = components.locomotives
        let expected = 3
        let blue = Card.filter(cards: cards, on: .blue)
        XCTAssertEqual(blue.count, components.meta.cards.blue.total)
        XCTAssertEqual(blue.count, expected)
    }

    func testCardTotals() throws {
        let cards = components.locomotives

        let green =  Card.filter(cards: cards, on: .green).count
        let yellow = Card.filter(cards: cards, on: .yellow).count
        let red = Card.filter(cards: cards, on: .red).count
        let blue =  Card.filter(cards: cards, on: .blue).count

        let total = green + yellow + red + blue
        XCTAssertEqual( total, components.meta.cards.total )
    }

    func testCapacities() throws {
        let factories = components.factories
        let totalCapacity = factories.reduce(0, { $0 + $1.orderCapacity }  )
        XCTAssertEqual(totalCapacity, components.meta.totalCapacity)
    }


}
