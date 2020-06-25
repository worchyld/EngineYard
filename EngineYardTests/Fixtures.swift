//
//  Fixtures.swift
//  EngineYardTests
//
//  Created by Amarjit on 24/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

@testable import EngineYard
import  XCTest

struct Fixtures {
    static var locomotives: [Locomotive] {
        let greenFirst = Locomotive(id: UUID(), ref: "green.1", name: "green.1", avatar: "green-1.png", cost: 4, generation: .first, livery: .green)
        let redFirst = Locomotive(id: UUID(), ref: "red.1", name: "red.1", avatar: "red-1.png", cost: 8, generation: .first, livery: .red)
        let yellowFirst = Locomotive(id: UUID(), ref: "yellow.1", name: "yellow.1", avatar: "yellow-1.png", cost: 12, generation: .first, livery: .yellow)
        let blueFirst = Locomotive(id: UUID(), ref: "blue.1", name: "blue.1", avatar: "blue-1.png", cost: 18, generation: .first, livery: .blue)

        return [greenFirst, redFirst, yellowFirst, blueFirst]
    }

    static var factories: [Factory] {
        let greenFirst = Factory(id: UUID(), ref: "green.1", avatar: "green.1", cost: 4, initialOrder: 0, existingOrders: [], completedOrders: [], cards: [], available: false, livery: .green, generation: .first, rusting: Rusting.notRusting, orderCapacity: 3)
        let redFirst = Factory(id: UUID(), ref: "green.1", avatar: "green.1", cost: 4, initialOrder: 0, existingOrders: [], completedOrders: [], cards: [], available: false, livery: .green, generation: .first, rusting: Rusting.notRusting, orderCapacity: 3)
        let yellowFirst = Factory(id: UUID(), ref: "yellow.1", avatar: "yellow.1", cost: 12, initialOrder: 0, existingOrders: [], completedOrders: [], cards: [], available: false, livery: .blue, generation: .first, rusting: Rusting.notRusting, orderCapacity: 3)
        let blueFirst = Factory(id: UUID(), ref: "blue.1", avatar: "blue.1", cost: 18, initialOrder: 0, existingOrders: [], completedOrders: [], cards: [], available: false, livery: .blue, generation: .first, rusting: Rusting.notRusting, orderCapacity: 3)

        return [greenFirst, redFirst, yellowFirst, blueFirst]
    }
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
