//
//  FixturesLoaderAPI.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

//protocol GameLocalDataAPIInputProtocol: class {
//    func fetchFixtures(from bundle: Bundle) throws
//}
protocol HandleResponseDelegate: class {
    func handleResponse(result: Result<Response, Error> )
}

typealias ResponseHandler = (Result<Response, Error>) -> Void

final class FixturesLoaderAPI {
    static let shared = FixturesLoaderAPI()

    private init() { }

    public func fetchFixtures(from bundle: Bundle, completion: @escaping ResponseHandler ) {
        FixturesLoaderAPI.debugInfo(bundle: bundle)


        DispatchQueue(label: "utility.dispatch", qos: .utility).sync()
        {
            autoreleasepool {
                do {
                    let result = try bundle.decode(Response.self, from: "board.json", dateDecodingStrategy: .deferredToDate, keyDecodingStrategy: .convertFromSnakeCase)
                    print ("got response = \(result)")

                    completion(Result.success(result))
                    //DispatchQueue.main.async { completion( Result.success(result) )}

                }
                catch {
                    print ("got error = \(error as Any)")

                    completion(Result.failure(error))
                    //DispatchQueue.main.async { completion( Result.failure(error) )}

                }
            }
        }

    }

    private static func debugInfo(bundle: Bundle) {
        #if DEBUG

        print ("\n\n--Bundle debug----")
        print ("bundle path: \(bundle.bundlePath)")
        print ("bundle loaded: \(bundle.isLoaded)")
        print ("Identifier:  \(bundle.bundleIdentifier as Any)")
        print ("Preferred localisations: \(bundle.preferredLocalizations)")
        print ("Dev Localisation: \(bundle.developmentLocalization as Any)")
        print ("----------------\n\n")

        #endif
    }
}
