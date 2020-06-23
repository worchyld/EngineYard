//
//  EY+Bundle.swift
//  EngineYard
//
//  Created by Amarjit on 23/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation


extension Bundle {
    public static var appName: String {
        guard let str = main.object(forInfoDictionaryKey: "CFBundleName") as? String else { return "" }
        return str
    }

    public static var appVersion: String {
        guard let str = main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else { return "" }
        return str
    }

    public static var appBuild: String {
        guard let str = main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else { return "" }
        return str
    }

    public static var identifier: String {
        guard let str = main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String else { return "" }
        return str
    }
}


extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String,
                              dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                              keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) throws -> T {

        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
