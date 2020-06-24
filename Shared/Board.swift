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
    var board: Board?

    func start() throws {
        do {
            let board = try loadInitialBoard()
            print ("board: \(board as Any)")
        }
        catch {
            throw error
        }
    }
}

extension TrainGame {
    func loadInitialBoard() throws -> Board? {
        let board = [Space?](repeating: nil, count: 14)

        var jsonResult: Result<Response, Error>?

        // 1. get response object from data in local json file

        self.loadJSON(from: "boards.json", in: Bundle.main) { (result) in
            DispatchQueue.main.async {
                jsonResult = result
            }
        }

        switch jsonResult {
        case .success(let response):
            print (response)

        case .failure(let error):
            print ("Error -- \(error)")
            throw error
        case .none:
            throw BundleError.unknown("Unknown error loading from bundle")
        }


        // 2. prepare/build the board

        // 3. save to cloudkit/database?

        return board
    }


    func loadJSON(from file: String = "board.json", in bundle: Bundle, completion: @escaping ResponseHandler ) {
        let api = FixturesLoaderAPI.shared

        api.fetchFixtures(from: file, in: bundle) { (results) in
            completion(results)
        }
    }

}


