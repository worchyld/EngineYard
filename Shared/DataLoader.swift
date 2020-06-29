//
//  DataLoader.swift
//  EngineYard
//
//  Created by Amarjit on 27/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class DataLoader {
    static let shared = DataLoader()

    private init() { }

    public func load(from bundle: Bundle = Bundle.main, file: String) -> Result<Response, Error> {
        do {
            let result = try bundle.decode(Response.self, from: file, dateDecodingStrategy: .deferredToDate, keyDecodingStrategy: .convertFromSnakeCase)

            return Result.success(result)
        }
        catch {
            return Result.failure(error)
        }
    }

    public func load(from directoryURL: String) -> Result<Response, Error>? {
        // #NOT IMPLEMENTED
        return nil
    }

    public func save(rootObject: Response) -> Result<Int, Error> {
        let result = self.encode(rootObject: rootObject)

        switch result {

        case .success(let data):
            print ("RECIEVED DATA >>> \(data)")

            if let jsonString = String(data: data, encoding: .utf8) {
                print ("JSON STRING >> \(jsonString)")

                return Result.success(data.count)
            }
            else {
                let error = NSError.init(domain: "Save error -- JSON was malformed", code: 0, userInfo: nil)
                return Result.failure(error)
            }

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
