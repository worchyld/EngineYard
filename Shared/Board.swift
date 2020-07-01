//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias Board = [Space?]

class TrainGame {
    var board: Board!

    func start(_ bundle: Bundle = Bundle.main) throws {
        do {
            self.board = try TrainGame.loadInitialBoard(bundle: bundle)
        }
        catch {
            throw error
        }
    }
}


extension TrainGame {
    public static func loadInitialBoard(bundle: Bundle) throws -> Board? {
        var board = [Space?](repeating: nil, count: 14)

        // Load JSON from Bundle
        let api = DataLoader.shared
        let result = api.load(from: bundle, file: Constants.boardJSONFile)

        switch result {
        case .success(let response):
            //print ("RESPONSE FOUND >> \(response)")

            guard let factories = response.factories else {
                throw NSError(domain: "Couldn't load the factories from data", code: 0, userInfo: nil)
            }

            guard let spaces = response.spaces else {
                throw NSError(domain: "Couldn't find any board spaces from JSON data", code: 0, userInfo: nil)
            }

            guard (spaces.count == board.count) else {
                throw NSError(domain: "The spaces count mis-match", code: 0, userInfo: ["spaces": spaces.count, "board": board.count])
            }

            guard (factories.count == spaces.count) else {
                throw NSError(domain: "Factories/Spaces mis-match", code: 0, userInfo: nil)
            }

            // Link the space to the factory
            for space in spaces {
                guard let factory = factories.filter({ $0.generation == space.generation && $0.livery == space.livery }).first else {
                    throw NSError(domain: "Cannot find factory: \(space.livery) \(space.generation)", code: 0, userInfo: nil)
                }
                space.factory = factory
            }

            board = spaces

            return board
        case .failure(let error):
            throw error
        }

        //return board
    }

}
