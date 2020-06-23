//
//  EY+Bundle.swift
//  EngineYard
//
//  Created by Amarjit on 23/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

public enum BundleError: Error, Equatable {
    case fileNotFound(_ file: String)
    case cannotLoad(_ file: String)
    case failedToDecode(_ file: String, context: String? )
    case unknown(_ reason: String)
}

extension BundleError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .fileNotFound(file):
            return NSLocalizedString("Failed to locate: \(file) in bundle", comment: "bundle.error.fileNotFound")

        case let .cannotLoad(file):
            return NSLocalizedString("Failed to load: \(file) from bundle.", comment: "bundle.error.cannotLoadFile")

        case let .failedToDecode(file, context):
            let context = context ?? "Unknown reason"
            return NSLocalizedString("Failed to decode \(file) from bundle.\n (Context: \(context))", comment: "bundle.error.failedToDecode")

        case let .unknown(reason):
            return NSLocalizedString("Failed -- \(reason)", comment: "bundle.error.unknownreason")

        }
        
    }
}


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
            //fatalError("Failed to locate \(file) in bundle.")
            throw BundleError.fileNotFound(file)
        }

        guard let data = try? Data(contentsOf: url) else {
            //fatalError("Failed to load \(file) from bundle.")
            throw BundleError.cannotLoad(file)
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            //fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
            throw BundleError.failedToDecode(file, context: "Missing key: \(key.stringValue) - Context: \(context.debugDescription)")

        } catch DecodingError.typeMismatch(_, let context) {
            //fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
            throw BundleError.failedToDecode(file, context: "Mismatch: \(context.debugDescription)")

        } catch DecodingError.valueNotFound(let type, let context) {
            //fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
            throw BundleError.failedToDecode(file, context: "Missing type: \(type) -- \(context.debugDescription)")

        } catch DecodingError.dataCorrupted(_) {
            //fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
            throw BundleError.failedToDecode(file, context: "Data corrupted - Invalid JSON")

        } catch {
            //fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
            throw BundleError.failedToDecode(file, context: error.localizedDescription)
        }
    }
}
