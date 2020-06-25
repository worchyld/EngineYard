//
//  TestBoardInitialisation.swift
//  EngineYardTests
//
//  Created by Amarjit on 24/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class BoardInit_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }


    func testBoardInit() throws {
        let bundle = Bundle(for: type(of: self))
        let file = Constants.boardJSONFile
        let api = DataLoader.shared
        let result = api.load(from: bundle, file: file)

        switch result {
        case .success(let response):

            guard let meta = response.meta else {
                XCTFail("No meta found")
                return
            }

            guard let factories = response.factories else {
                XCTFail("No factories found")
                return
            }
            guard let cards = response.cards else {
                XCTFail("No cards found")
                return
            }

            for f in factories {
                XCTAssertNil(f.cards)
            }

            for f in factories {

                var f = f
                XCTAssertEqual(f.cost % 4, 0)
                XCTAssertNotNil(f.references)
                let livery = f.livery

                print ("\n\nEvaluating: \(f.name), \(f.livery), \(f.generation)\n")

                XCTAssertNotNil(f.references)
                XCTAssertTrue(f.generation.rawValue > 0 && f.generation.rawValue <= 5)

                guard let references = f.references else {
                    XCTFail("No references found")
                    return
                }

                let generation = (f.generation.rawValue - 1)

                for (index, ref) in references.enumerated() {

                    print ("\nINDEX -- \(index), REF: \(ref.id)")


                    let metaGenerations: Int = {
                        switch livery {
                        case .green:
                            return meta.cards.green.generations[generation]
                        case .red:
                            return meta.cards.red.generations[generation]
                        case .yellow:
                            return meta.cards.yellow.generations[generation]
                        case .blue:
                            return meta.cards.blue.generations[generation]
                        }
                    }()

                    print ("\nMeta found: \(metaGenerations) results for \(f.livery) \(f.generation)")

                    XCTAssertEqual(references.count, metaGenerations, "ref: \(references.count) vs \(metaGenerations) -- (Failed on :\(f.livery), \(f.generation), Ref: \(ref.id)")

                    let foundList = cards.filter { r in references.contains(where: { $0.id == r.id }) }

                    XCTAssertEqual(foundList.count, metaGenerations, "(Failed on :\(f.livery), \(f.generation), Found: \(foundList.count) vs \(metaGenerations)")
                }

            }

            for f in factories {
                print (f.name, f.cards as Any)
            }


        case .failure(let error):
           throw(error)
        }
    }

}
