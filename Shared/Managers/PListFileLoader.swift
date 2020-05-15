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
    enum FileError: Error {
        case fileHasNoData
        case filePathNotFound(path: String)
    }

    public static func getDataFrom(filename: String, completionHandler: @escaping (Data?, Error?) -> Void) {
        let fileManager = FileManager.default
        let documentsDirectory = FileManager.documentsDirectory()
        let URL = documentsDirectory.appendingPathComponent(filename)

        guard fileManager.fileExists(atPath: URL.path) else {
            completionHandler(nil, FileError.filePathNotFound(path: URL.path))
            return
        }

        let serialQueue = DispatchQueue(label: "GetDataFromFile")
        do {
            let _ = try serialQueue.sync {
                let data = try Data(contentsOf: URL, options: .mappedIfSafe)
                completionHandler(data, nil)
            }
        } catch {
            completionHandler(nil, error)
        }
        
        /*
        DispatchQueue.global(qos: .utility).async {
            do {
                let data = try Data(contentsOf: URL, options: .mappedIfSafe)
                DispatchQueue.main.async {
                    completionHandler(data, nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    print ("failed with error found")
                   completionHandler(nil, error)
                }
            }
        }*/
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
