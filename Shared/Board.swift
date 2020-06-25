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
        var board = [Factory?](repeating: nil, count: 14)



        return board
    }

}

//typealias ResponseHandler = (Result<Response, Error>) -> Void

class DataLoader {
    static let shared = DataLoader()

    private init() { }

    public func load(from bundle: Bundle = Bundle.main, _ file: String = Constants.boardJSONFile) -> Result<Response, Error>? {
        do {
            let result = try bundle.decode(Response.self, from: file, dateDecodingStrategy: .deferredToDate, keyDecodingStrategy: .convertFromSnakeCase)

            return Result.success(result)
        }
        catch {
            return Result.failure(error)
        }
    }

    public func save(rootObject: Response) -> Result<Bool, Error> {
        let result = self.encode(rootObject: rootObject)

        switch result {

        case .success(let data):
            print ("RECIEVED DATA >>> \(data)")

            if let jsonString = String(data: data, encoding: .utf8) {
                print ("JSON STRING >> \(jsonString)")
                #warning("save not implemented yet")
            }

            return Result.success(true)

        case .failure(let error):
            return Result.failure(error)

        }
    }

    internal func encode(rootObject: Response) -> Result<Data, Error> {
        let encoder = JSONEncoder()
        do {
            let gameData = try encoder.encode( rootObject.self )
            return Result.success(gameData)
        }
        catch {
            return Result.failure(error)
        }
    }

}
