//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias Board = [Train?]

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
        var board = [Train?](repeating: nil, count: 14)

        // Load JSON from Bundle
        let api = DataLoader.shared
        let result = api.load(from: bundle, file: Constants.boardJSONFile)

        switch result {
        case .success(let response):
            print ("RESPONSE RETURNED >> \(response)")

            guard let trains = response.trains else {
                throw NSError(domain: "Couldn't load the trains from data", code: 0, userInfo: nil)
            }

            for (index, train) in trains.enumerated() {
                board[index] = train
            }

            return board
        case .failure(let error):
            throw error
        }

        //return board
    }

}
