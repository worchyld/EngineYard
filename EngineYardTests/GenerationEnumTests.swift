//
//  GenerationEnumTests.swift
//  EngineYardTests
//
//  Created by Amarjit on 20/11/2020.
//

import XCTest

@testable import EngineYard

class GenerationEnumTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGenerationDescription() {
        let gen = Generation.first
        print (gen.description)
    }
}
