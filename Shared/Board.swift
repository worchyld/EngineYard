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


        // 1. get response object from data in local json file
        do {
            let response = try getLocalJSON()
            print (response as Any)
        }
        catch {
            throw error
        }


        // 2. prepare/build the board

        // 3. save to cloudkit/database?

        return board
    }


    func getLocalJSON(file: String = Constants.boardJSONFile) throws -> Response? {
        let api = FixturesLoaderAPI.shared

        var responseResult: Result<Response, Error>?

        api.fetchFixtures(from: file) { (results) in
            responseResult = results
        }

        guard let result = responseResult else {
            throw BundleError.unknown("ResponseResult-Failed")
        }

        switch result {
        case .success(let response):
            print (response)
            return response

        case .failure(let error):
            print ("Error -- \(error)")
            throw error

        }
    }


    /*
    func loadJSON(from file: String = Constants.boardJSONFile, completion: @escaping ResponseHandler ) {
        let api = FixturesLoaderAPI.shared

        api.fetchFixtures(from: file) { (results) in
            completion(results)
        }
    }*/

}


