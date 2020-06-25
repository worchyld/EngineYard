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
    static var mockLocos: [Locomotive] {
        let greenFirst = Locomotive(id: UUID(), name: "green.1", avatar: "green-1.png", cost: 4, generation: .first, livery: .green)
        let redFirst = Locomotive(id: UUID(), name: "red.1", avatar: "red-1.png", cost: 8, generation: .first, livery: .red)
        let yellowFirst = Locomotive(id: UUID(),  name: "yellow.1", avatar: "yellow-1.png", cost: 12, generation: .first, livery: .yellow)
        let blueFirst = Locomotive(id: UUID(), name: "blue.1", avatar: "blue-1.png", cost: 18, generation: .first, livery: .blue)

        return [greenFirst, redFirst, yellowFirst, blueFirst]
    }

    static var mockFactories: [Factory] {
        let greenFirst = Factory(id: UUID(), name: "green.1", avatar: "green.1", cost: 4, initialOrder: 0, existingOrders: [], completedOrders: [], cards: [], available: false, livery: .green, generation: .first, rusting: Rusting.notRusting, orderCapacity: 3)
        let redFirst = Factory(id: UUID(), name: "red.1",avatar: "green.1", cost: 4, initialOrder: 0, existingOrders: [], completedOrders: [], cards: [], available: false, livery: .green, generation: .first, rusting: Rusting.notRusting, orderCapacity: 3)
        let yellowFirst = Factory(id: UUID(), name: "yellow.1", avatar: "yellow.1", cost: 12, initialOrder: 0, existingOrders: [], completedOrders: [], cards: [], available: false, livery: .blue, generation: .first, rusting: Rusting.notRusting, orderCapacity: 3)
        let blueFirst = Factory(id: UUID(), name: "blue.1",avatar: "blue.1", cost: 18, initialOrder: 0, existingOrders: [], completedOrders: [], cards: [], available: false, livery: .blue, generation: .first, rusting: Rusting.notRusting, orderCapacity: 3)

        return [greenFirst, redFirst, yellowFirst, blueFirst]
    }

    private static func MakeFactory(avatar: String, cost: Int, livery: Livery, generation: Generation, orderCapacity: Int) -> Factory {
        return Factory.init(id: UUID(), name:"\(livery)-\(generation.rawValue)", avatar: avatar, cost: cost, initialOrder: nil, existingOrders: nil, completedOrders: nil, cards: nil, available: false, livery: livery, generation: generation, rusting: .notRusting, orderCapacity: orderCapacity, references: nil)
    }

    static var factories: [Factory] = [
        MakeFactory(avatar: "green-1.png", cost: 4, livery: .green, generation: .first, orderCapacity:       3),
        MakeFactory(avatar: "red-1.png",  cost: 8, livery: .red, generation: .first, orderCapacity:          3),
        MakeFactory(avatar: "yellow-1.png", cost: 12,  livery: .yellow, generation: .first, orderCapacity:   2),
        MakeFactory(avatar: "blue-1.png",  cost: 16, livery: .blue, generation: .first, orderCapacity:       1),
        MakeFactory(avatar: "green-2.png",  cost: 20, livery: .green, generation: .second, orderCapacity:    4),
        MakeFactory(avatar: "red-1.png",  cost: 24, livery: .red, generation: .second, orderCapacity:        3),
        MakeFactory(avatar: "yellow-2.png", cost: 28,  livery: .yellow, generation: .second, orderCapacity:  3),
        MakeFactory(avatar: "green-3.png",  cost: 32, livery: .green, generation: .third, orderCapacity:     4),
        MakeFactory(avatar: "blue-2.png",  cost: 36, livery: .blue, generation: .second, orderCapacity:      2),
        MakeFactory(avatar: "red-3.png",  cost: 40, livery: .red, generation: .third, orderCapacity:         4),
        MakeFactory(avatar: "green-4.png",  cost: 44, livery: .green, generation: .fourth, orderCapacity:    5),
        MakeFactory(avatar: "yellow-3.png",  cost: 48, livery: .yellow, generation: .third, orderCapacity:   3),
        MakeFactory(avatar: "red-4.png",  cost: 52, livery: .red, generation: .fourth, orderCapacity:        4),
        MakeFactory(avatar: "green-5.png",  cost: 56, livery: .green, generation: .fifth, orderCapacity:     5)
    ]


    static var cards: [Card]  =  [
        // Green.first (x4)
        Card.init(id: UUID(), name: "Green.1", avatar: "green-1.png", cost: 4, generation: .first, livery: .green ),
        Card.init(id: UUID(), name: "Green.1", avatar: "green-1.png", cost: 4, generation: .first, livery: .green ),
        Card.init(id: UUID(), name: "Green.1", avatar: "green-1.png", cost: 4, generation: .first, livery: .green ),
        Card.init(id: UUID(), name: "Green.1", avatar: "green-1.png", cost: 4, generation: .first, livery: .green ),

        // Red.first (x3)
        Card.init(id: UUID(), name: "Red.1", avatar: "red-1.png", cost: 8, generation: .first, livery: .red ),
        Card.init(id: UUID(), name: "Red.1", avatar: "red-1.png", cost: 8, generation: .first, livery: .red ),
        Card.init(id: UUID(), name: "Red.1", avatar: "red-1.png", cost: 8, generation: .first, livery: .red ),

        // Yellow.first (x2)
        Card.init(id: UUID(), name: "Yellow.1", avatar: "yellow-1.png", cost: 12, generation: .first, livery: .yellow ),
        Card.init(id: UUID(), name: "Yellow.1", avatar: "yellow-1.png", cost: 12, generation: .first, livery: .yellow ),

        // Blue.first (x1)
        Card.init(id: UUID(), name: "Blue.1", avatar: "blue-1.png", cost: 16, generation: .first, livery: .blue ),

        // Green.second (x4)
        Card.init(id: UUID(), name: "Green.2", avatar: "green-2.png" , cost: 20, generation: .second, livery: .green ),
        Card.init(id: UUID(), name: "Green.2", avatar: "green-2.png" , cost: 20, generation: .second, livery: .green ),
        Card.init(id: UUID(), name: "Green.2", avatar: "green-2.png" , cost: 20, generation: .second, livery: .green ),
        Card.init(id: UUID(), name: "Green.2", avatar: "green-2.png" , cost: 20, generation: .second, livery: .green ),

        // Red.second (x3)
        Card.init(id: UUID(), name: "Red.2", avatar: "red-2.png", cost: 24, generation: .second, livery: .red ),
        Card.init(id: UUID(), name: "Red.2", avatar: "red-2.png", cost: 24, generation: .second, livery: .red ),
        Card.init(id: UUID(), name: "Red.2", avatar: "red-2.png", cost: 24, generation: .second, livery: .red ),

        // Yellow.second (x2)
        Card.init(id: UUID(), name: "Yellow.2", avatar: "yellow-2.png", cost: 28, generation: .second, livery: .yellow),
        Card.init(id: UUID(), name: "Yellow.2", avatar: "yellow-2.png", cost: 28, generation: .second, livery: .yellow),

        // Green.third (x4)
        Card.init(id: UUID(), name: "Green.3", avatar: "green-3.png", cost: 32, generation: .third, livery: .green),
        Card.init(id: UUID(), name: "Green.3", avatar: "green-3.png", cost: 32, generation: .third, livery: .green),
        Card.init(id: UUID(), name: "Green.3", avatar: "green-3.png", cost: 32, generation: .third, livery: .green),
        Card.init(id: UUID(), name: "Green.3", avatar: "green-3.png", cost: 32, generation: .third, livery: .green),

        // Blue.second (x2)
        Card.init(id: UUID(), name: "Blue.2", avatar: "blue-2.png" , cost: 36, generation: .second, livery: .blue),
        Card.init(id: UUID(), name: "Blue.2", avatar: "blue-2.png" , cost: 36, generation: .second, livery: .blue),

        // Red.third (x3)
        Card.init(id: UUID(), name: "Red.3", avatar: "red-3.png", cost: 40, generation: .third, livery: .red),
        Card.init(id: UUID(), name: "Red.3", avatar: "red-3.png", cost: 40, generation: .third, livery: .red),
        Card.init(id: UUID(), name: "Red.3", avatar: "red-3.png", cost: 40, generation: .third, livery: .red),

        // Green.fourth (x4)
        Card.init(id: UUID(), name: "Green.4", avatar: "green-4.png", cost: 44, generation: .fourth, livery: .green),
        Card.init(id: UUID(), name: "Green.4", avatar: "green-4.png", cost: 44, generation: .fourth, livery: .green),
        Card.init(id: UUID(), name: "Green.4", avatar: "green-4.png", cost: 44, generation: .fourth, livery: .green),
        Card.init(id: UUID(), name: "Green.4", avatar: "green-4.png", cost: 44, generation: .fourth, livery: .green),

        // Yellow.third (x3)
        Card.init(id: UUID(), name: "Yellow.3", avatar: "yellow-3.png" , cost: 48, generation: .third, livery: .yellow),
        Card.init(id: UUID(), name: "Yellow.3", avatar: "yellow-3.png" , cost: 48, generation: .third, livery: .yellow),
        Card.init(id: UUID(), name: "Yellow.3", avatar: "yellow-3.png" , cost: 48, generation: .third, livery: .yellow),

        // Red.fourth (x4)
        Card.init(id: UUID(), name: "Red.4", avatar: "red-4.png", cost: 52, generation: .fourth, livery: .red),
        Card.init(id: UUID(), name: "Red.4", avatar: "red-4.png", cost: 52, generation: .fourth, livery: .red),
        Card.init(id: UUID(), name: "Red.4", avatar: "red-4.png", cost: 52, generation: .fourth, livery: .red),
        Card.init(id: UUID(), name: "Red.4", avatar: "red-4.png", cost: 52, generation: .fourth, livery: .red),

        // Green.fifth (x4)
        Card.init(id: UUID(), name: "Green.5", avatar: "green-5.png" , cost: 56, generation: .fifth, livery: .green),
        Card.init(id: UUID(), name: "Green.5", avatar: "green-5.png" , cost: 56, generation: .fifth, livery: .green),
        Card.init(id: UUID(), name: "Green.5", avatar: "green-5.png" , cost: 56, generation: .fifth, livery: .green),
        Card.init(id: UUID(), name: "Green.5", avatar: "green-5.png" , cost: 56, generation: .fifth, livery: .green)
    ]

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
