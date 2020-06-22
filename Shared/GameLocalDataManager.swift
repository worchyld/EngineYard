//
//  GameLocalDataManager.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol GameLocalDataManagerInputProtocol: class {
    //func fetchContent(amount: Int) throws -> [Content]
    func fetchFixtures() throws
}

class GameLocalDataAPI: GameLocalDataManagerInputProtocol {

    private var resourceInfo: ResourceInfo

    struct ResourceInfo {
        let bundle: Bundle
        let resource: String
        let resourceType: String?

        init(bundle: Bundle = Bundle.main, resource: String = "board.json", resourceType: String? = nil) {
            self.bundle = bundle
            self.resource = resource
            self.resourceType = resourceType
        }
    }

    init(resourceInfo: ResourceInfo) {
        self.resourceInfo = resourceInfo
    }

    func fetchFixtures() throws {
        GameLocalDataAPI.debugInfo(bundle: resourceInfo.bundle)

        if let path = resourceInfo.bundle.path(forResource: resourceInfo.resource, ofType: resourceInfo.resourceType) {

            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url, options: .mappedIfSafe)

                print(data as Any)


                getJSONResponse(from: data
                    , completionHandler: { result in

                        switch result {
                        case .success(let response):
                            print ("Response -->> \(response)")
                        case .failure(let error):
                            print ("Error -->> \(error.localizedDescription) ")
                        }
                })


            } catch {
                throw error
            }
        }
    }

    func getJSONResponse(from data: Data, completionHandler: @escaping((Result<Response, Error>)) -> ())  {

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
