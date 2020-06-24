//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias Board = [Factory?]

class TrainGame {
    var board: Board!

    func start() throws {
//        do {
//            let board = try loadInitialBoard()
//            print ("board: \(board as Any)")
//        }
//        catch {
//            throw error
//        }
    }
}


/**
extension TrainGame {
    func loadInitialBoard() throws -> Board? {
        var board = [Space?](repeating: nil, count: 14)


        // 1. get response object from data in local json file
        do {

            let api = FixturesLoaderAPI.shared

            guard let response = try api.loadJSON() else {
                throw BundleError.unknown("Did not find response from local file")
            }


            // 2. prepare/build the board
            let results = try prepare(board: board, with: response)

            print (results)
            board = results


            // 3. save to cloudkit/database/disk?

        }
        catch {
            throw error
        }

        return board
    }


    internal func prepare(board: [Space?], with response: Response) throws -> Board {

        guard let factories = response.factories else {
            throw BundleError.unknown("Factory data not found")
        }
        guard let spaces = response.spaces else {
            throw BundleError.unknown("Space data not found")
        }
        guard let locomotives = response.locomotives else {
            throw BundleError.unknown("Locomotive data not found")
        }
        guard (spaces.count == board.count) else {
            throw BundleError.unknown("Invalid board count")
        }

        var board = board

        print ("\nboard -- \(board)")

        return board
    }


}
**/
