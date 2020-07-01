//
//  Fixtures.swift
//  EngineYardTests
//
//  Created by Amarjit on 24/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
@testable import EngineYard
import  XCTest

struct Card: Identifiable {
    let id : UUID
    let name : String
    let avatar : String
    let cost : Int
    let generation : Generation
    let livery : Livery
}

struct Fixtures {
    static let cardJSONString =
"""
{ "cards": [ { "id": "f52358a2-1b99-4aa5-9210-11995fd28672", "name": "Green.first (x4)", "avatar": "green-1.png", "cost": 4, "livery": 1, "generation": 1 }, { "id": "4c45158b-e03b-4203-86d3-c7b3365144fc", "name": "Green.first (x4)", "avatar": "green-1.png", "cost": 4, "livery": 1, "generation": 1 }, { "id": "526b1619-0756-428a-a072-d1c4ff5bc660", "name": "Green.first (x4)", "avatar": "green-1.png", "cost": 4, "livery": 1, "generation": 1 }, { "id": "7c712a41-9975-433a-901f-4b592ddcc909", "name": "Green.first (x4)", "avatar": "green-1.png", "cost": 4, "livery": 1, "generation": 1 }, { "id": "1425acca-315f-4037-b586-a0e71fedc856", "name": "Red.first (x3)", "avatar": "red-1.png", "cost": 8, "livery": 2, "generation": 1 }, { "id": "60b4c87c-6c2e-483f-936f-323760d5b461", "name": "Red.first (x3)", "avatar": "red-1.png", "cost": 8, "livery": 2, "generation": 1 }, { "id": "c181c758-661f-4fd3-9e20-7c7816e8d355", "name": "Red.first (x3)", "avatar": "red-1.png", "cost": 8, "livery": 2, "generation": 1 }, { "id": "0e3ed925-e3fe-484c-b69e-b320e99dea91", "name": "Yellow.first (x2)", "avatar": "yellow-1.png", "cost": 12, "livery": 3, "generation": 1 }, { "id": "1ed912c9-f35c-4fcb-a2d0-863008da14b2", "name": "Yellow.first (x2)", "avatar": "yellow-1.png", "cost": 12, "livery": 3, "generation": 1 }, { "id": "5269a3b2-d197-43ea-998f-63445235050d", "name": "Blue.first (x1)", "avatar": "blue-1.png", "cost": 16, "livery": 4, "generation": 1 }, { "id": "f62fc5ba-a297-4cd9-9264-7d4bfe752dc9", "name": "Green.second (x4)", "avatar": "green-2.png", "cost": 20, "livery": 1, "generation": 2 }, { "id": "6314d2f8-257f-4af8-b725-3ff64fc25b4e", "name": "Green.second (x4)", "avatar": "green-2.png", "cost": 20, "livery": 1, "generation": 2 }, { "id": "037441b2-f2c7-4a52-8752-530c31ba0dd6", "name": "Green.second (x4)", "avatar": "green-2.png", "cost": 20, "livery": 1, "generation": 2 }, { "id": "6b65ca5f-7687-4c8d-af8c-fd19b4e975df", "name": "Green.second (x4)", "avatar": "green-2.png", "cost": 20, "livery": 1, "generation": 2 }, { "id": "2f029850-023a-47ed-8ec6-7df8c1b3fb53", "name": "Red.second (x3)", "avatar": "red-2.png", "cost": 24, "livery": 2, "generation": 2 }, { "id": "7f9ad83a-a530-42ce-a3bc-bc79c3adf212", "name": "Red.second (x3)", "avatar": "red-2.png", "cost": 24, "livery": 2, "generation": 2 }, { "id": "1af691c8-b2d5-4ad9-8df8-a4ec47ebb8b4", "name": "Red.second (x3)", "avatar": "red-2.png", "cost": 24, "livery": 2, "generation": 2 }, { "id": "3f894792-b2f2-4796-a560-deaba15eeaf5", "name": "Yellow.second (x3)", "avatar": "yellow-2.png", "cost": 28, "livery": 3, "generation": 2 }, { "id": "6d0573c5-4c8f-40e1-bffb-f2738fbb7dcb", "name": "Yellow.second (x3)", "avatar": "yellow-2.png", "cost": 28, "livery": 3, "generation": 2 }, { "id": "3bbdddf7-fb51-44e9-953f-375d6aeac621", "name": "Green.third (x4)", "avatar": "green-3.png", "cost": 32, "livery": 1, "generation": 3 }, { "id": "5e26958e-1505-4488-ab11-9b540980432f", "name": "Green.third (x4)", "avatar": "green-3.png", "cost": 32, "livery": 1, "generation": 3 }, { "id": "de090b59-d382-4f66-adcf-26b1e912cee7", "name": "Green.third (x4)", "avatar": "green-3.png", "cost": 32, "livery": 1, "generation": 3 }, { "id": "f9bab0ed-8c16-4c52-8c76-27a7eb94fcbc", "name": "Green.third (x4)", "avatar": "green-3.png", "cost": 32, "livery": 1, "generation": 3 }, { "id": "4ac8b2a5-5bb1-40fb-becc-7f76a121b435", "name": "Blue.second (x2)", "avatar": "blue-2.png", "cost": 36, "livery": 4, "generation": 2 }, { "id": "c5bfdf0f-700c-4c75-808f-2f7a3e520ef0", "name": "Blue.second (x2)", "avatar": "blue-2.png", "cost": 36, "livery": 4, "generation": 2 }, { "id": "6249246f-f8a5-492b-8627-a471995bf525", "name": "Red.third (x3)", "avatar": "red-3.png", "cost": 40, "livery": 2, "generation": 3 }, { "id": "79904698-1fed-4871-9066-c16babf515da", "name": "Red.third (x3)", "avatar": "red-3.png", "cost": 40, "livery": 2, "generation": 3 }, { "id": "96a2e18d-1d19-45ba-a008-ed0299dc0de4", "name": "Red.third (x3)", "avatar": "red-3.png", "cost": 40, "livery": 2, "generation": 3 }, { "id": "c8f22644-aac5-4884-b0b5-6905f8ae8e32", "name": "Green.fourth (x4)", "avatar": "green-4.png", "cost": 44, "livery": 1, "generation": 4 }, { "id": "29439ff0-11d3-4573-9a71-b291f21cc24f", "name": "Green.fourth (x4)", "avatar": "green-4.png", "cost": 44, "livery": 1, "generation": 4 }, { "id": "a67e02b9-acfd-4751-8b67-e0f162dd2a28", "name": "Green.fourth (x4)", "avatar": "green-4.png", "cost": 44, "livery": 1, "generation": 4 }, { "id": "92678f37-aeab-431d-8c89-4a7b9d5f4829", "name": "Green.fourth (x4)", "avatar": "green-4.png", "cost": 44, "livery": 1, "generation": 4 }, { "id": "398c72b4-22b7-44c6-97bb-ae2a80808890", "name": "Yellow.third (x3)", "avatar": "yellow-3.png", "cost": 48, "livery": 3, "generation": 3 }, { "id": "f78b60f0-10d6-4009-befe-77a2a9ee4149", "name": "Yellow.third (x3)", "avatar": "yellow-3.png", "cost": 48, "livery": 3, "generation": 3 }, { "id": "6c3163d3-65f4-466f-aa13-9e045547a533", "name": "Yellow.third (x3)", "avatar": "yellow-3.png", "cost": 48, "livery": 3, "generation": 3 }, { "id": "d0511da2-6d20-4801-96f2-7f435f4e7755", "name": "Red.fourth (x4)", "avatar": "red-4.png", "cost": 52, "livery": 2, "generation": 4 }, { "id": "59f2c4b4-bc46-413f-a3d6-5d9a9aacc662", "name": "Red.fourth (x4)", "avatar": "red-4.png", "cost": 52, "livery": 2, "generation": 4 }, { "id": "d8229a71-de42-4886-a3a2-30f66c550bc3", "name": "Red.fourth (x4)", "avatar": "red-4.png", "cost": 52, "livery": 2, "generation": 4 }, { "id": "8ea3affb-1173-4b13-b5fd-3e6ac1ecffb8", "name": "Red.fourth (x4)", "avatar": "red-4.png", "cost": 52, "livery": 2, "generation": 4 }, { "id": "8c23a803-f5ba-4ecc-9a6c-4660681fb101", "name": "Green.fifth (x4)", "avatar": "green-5.png", "cost": 56, "livery": 1, "generation": 5 }, { "id": "95739df6-9a35-45aa-888d-15bb45b2b590", "name": "Green.fifth (x4)", "avatar": "green-5.png", "cost": 56, "livery": 1, "generation": 5 }, { "id": "007bca6c-db4c-4733-a5b4-7a41468b0996", "name": "Green.fifth (x4)", "avatar": "green-5.png", "cost": 56, "livery": 1, "generation": 5 }, { "id": "0c64e11b-ce7d-445f-8029-7415b898e269", "name": "Green.fifth (x4)", "avatar": "green-5.png", "cost": 56, "livery": 1, "generation": 5 } ] }
"""

    static let mockFactory = Factory.init(id: UUID(), name: "FakeFactory", avatar: "green-1.png", livery: .green, generation: .first, cost: 4, rust: .new, cards: nil, maxDice: 3, trainPool: 3)
    static let mockCard = Card.init(id: UUID(), name: "Green-1", avatar: "green-1.png", cost: 4, generation: .first, livery: .green)
}

public func example(of description: String,
                    _ action: () -> Void) {
    print("\n", description, "")
    action()
}

extension XCTestCase {
    func assert<T>(_ result: Result<T, Error>?,
                   containsError expectedError: Error,
                   in file: StaticString = #file,
                   line: UInt = #line) {
        switch result {
        case .success?:
            XCTFail("No error thrown", file: file, line: line)
        case .failure(let error)?:
            XCTAssertEqual(
                error.localizedDescription,
                expectedError.localizedDescription,
                file: file, line: line
            )
        case nil:
            XCTFail("Result was nil", file: file, line: line)
        }
    }
}
