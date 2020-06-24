//
//  FixturesLoaderAPI.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias ResponseHandler = (Result<Response, Error>) -> Void

final class FixturesLoaderAPI {
    static let shared = FixturesLoaderAPI()

    private init() { }


    public func fetchFixtures(from filename: String, in bundle: Bundle, completion: @escaping ResponseHandler ) {
        FixturesLoaderAPI.debugInfo(bundle: bundle)


        DispatchQueue.global(qos: .utility).sync {

            do {
                let result = try bundle.decode(Response.self, from: filename, dateDecodingStrategy: .deferredToDate, keyDecodingStrategy: .convertFromSnakeCase)

                completion( Result.success(result) )

            }
            catch {
                completion( Result.failure(error) )
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
