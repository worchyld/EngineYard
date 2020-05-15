//
//  PListFileLoader.swift
//  EngineYardTests
//
//  Created by Amarjit on 15/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct PListFileLoader {
    private enum FileError: Error {
        case bundleNotFound
        case filePathNotFound(path: String)
        case fileNotFound(file: String)
        case unknownFileError
    }

    let bundle: Bundle

    var resourcePath: String? {
        return self.bundle.resourcePath
    }

    func load(filename: String) throws -> Data {
        let fileManager = FileManager.default
        let documentsDirectory = FileManager.documentsDirectory()

        let URL = documentsDirectory.appendingPathComponent(filename)

        guard fileManager.fileExists(atPath: URL.path) else {
            throw FileError.filePathNotFound(path: URL.path)
        }

        do {
            let data = try Data(contentsOf: URL, options: .mappedIfSafe)
            return data
        }
        catch {
            throw error
        }
    }
}
