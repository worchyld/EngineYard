//
//  GameLocalDataManager.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol GameLocalDataAPIInputProtocol: class {
    func fetchFixtures(from bundle: Bundle) throws
}
protocol HandleResponseDelegate: class {
    func handleResponse(result: Result<Response, Error> )
}

class FixturesLoaderAPI: GameLocalDataAPIInputProtocol {

    // #TODO -- should be a completion block
    func fetchFixtures(from bundle: Bundle) throws {
        FixturesLoaderAPI.debugInfo(bundle: bundle)

        do {
            let result = try bundle.decode(Response.self, from: "board.json", dateDecodingStrategy: .deferredToDate, keyDecodingStrategy: .convertFromSnakeCase)
            print (result)
        }
        catch {
            throw error
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
