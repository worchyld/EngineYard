//
//  JSONParser.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class JSONParser {
    public static func decodeJSON(from data: Data,
                                  completionBlock: @escaping (Response?, Error?) -> ()) {

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970

        do {
            let jsonResponse = try decoder.decode(Response.self, from: data)

            completionBlock(jsonResponse, nil)
        } catch {
            completionBlock(nil, error)
        }
    }
}
