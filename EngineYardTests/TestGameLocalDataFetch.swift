//
//  TestGameLocalDataFetch.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TestGameLocalDataFetch: XCTestCase {

    internal var response: Response?
    internal var components: Components?

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

        api.fetchFixtures(from: bundle) { [weak self] result in
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

    func testLoadData_ResponseNotNil() throws {
        XCTAssertNotNil(  self.response )
    }

    func testLocalData_ComponentsNotNil() throws {
        XCTAssertNotNil( self.components )
    }

    func testFactories() throws {
        guard let components = self.components else {
            return
        }
        let factories = components.factories
        XCTAssertEqual(factories.count, components.meta.boardSpaces)

    }
}
