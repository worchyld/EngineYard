//
//  GameLocalDataManager.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol GameLocalDataAPIInputProtocol: class {
    func fetchFixtures() throws
}
protocol HandleResponseDelegate: class {
    func handleResponse(result: Result<Response, Error> )
}

class GameLocalDataAPI: GameLocalDataAPIInputProtocol, HandleResponseDelegate {

    private weak var delegate: HandleResponseDelegate!

    struct Config {
       var bundle: Bundle
       var resource: String
       var ofType: String?
    }
    var config: Config?

    init(config: Config) {
        self.delegate = self
        self.config = config
    }

    func fetchFixtures() throws {
        guard let config = config else {
            throw NSError(domain: "Config missing", code: 0, userInfo: nil)
        }

        GameLocalDataAPI.debugInfo(bundle: config.bundle)

        if let url = config.bundle.url(forResource: config.resource, withExtension: config.ofType) {

            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)

                print(data as Any)

                decodeJSONResponse(from: data
                    , completionHandler: { result in

                    self.delegate.handleResponse(result: result)
                })

            } catch {
                throw error
            }

        }
        else {
            throw FileManagerError.couldNotLoadFile(config.resource)
        }

    }

    func handleResponse(result: Result<Response, Error> ) {
        switch result {
        case .success(let response):
            print ("Response -->> \(response)")

        case .failure(let error):
            print ("Error -->> \(error.localizedDescription) ")
        }
    }

    // not used yet
    private func useFileProvider(url: URL) {
        let fileProvider = LocalFileProvider()

        fileProvider.requestLocalFile(from: url) { (result) in
            switch result {
            case .success(let data):
                print ("Response -->> \(data)")

                self.decodeJSONResponse(from: data
                                   , completionHandler: { result in

                                   self.delegate.handleResponse(result: result)
                })


            case .failure(let error):
                print ("Error -->> \(error.localizedDescription) ")

            }
        }
    }

    private func decodeJSONResponse(from data: Data, completionHandler: @escaping((Result<Response, Error>)) -> ()) {

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .secondsSince1970

            let result = try decoder.decode(Response.self, from: data)

            completionHandler(.success(result))
        }
        catch {
            completionHandler(.failure(error))
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
