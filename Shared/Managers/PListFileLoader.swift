//
//  PListFileLoader.swift
//  EngineYardTests
//
//  Created by Amarjit on 15/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// A very basic PList loader
struct PListFileLoader {
    //typealias Operation = (Data?) -> ()

    private enum FileError: Error {
        case filePathNotFound(path: String)
    }

    let bundle: Bundle

    var resourcePath: String? {
        return self.bundle.resourcePath
    }

    func getDataFrom(filename: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        let fileManager = FileManager.default
        let documentsDirectory = FileManager.documentsDirectory()
        let URL = documentsDirectory.appendingPathComponent(filename)

        guard fileManager.fileExists(atPath: URL.path) else {
            completionHandler(nil, FileError.filePathNotFound(path: URL.path))
            return
        }

        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.name = "Get data from filename: \(filename)"

        let operation = BlockOperation(block: {
          print("start fetching \(filename)")
            do {
                let data = try Data(contentsOf: URL, options: .mappedIfSafe)
                print("after data loaded")
                completionHandler(data, nil)
            }
            catch {
                print("error occured trying to load data")
                queue.cancelAllOperations()
                completionHandler(nil, error)
            }
        })

        queue.addOperation(operation)
        queue.waitUntilAllOperationsAreFinished()
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
