//
//  FileManagerHelper.swift
//  EngineYard
//
//  Created by Amarjit on 13/07/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class FileManagerHelper: NSObject, FileManagerDelegate {
    private let fileName = "data.json"

    var fileURL : URL {
        let documentsPath = FileManager.documentsDirectory()
        let fileURL = documentsPath.appendingPathComponent(self.fileName)
        return fileURL
    }

    func fileWritable() -> Bool {
        let path = self.fileURL.path
        let filemgr = FileManager.default

        if filemgr.isWritableFile(atPath: path) {
            print("File is writable")
            return true
        } else {
            print("File is read-only")
            return false
        }
    }

    func fileExists() -> Bool {
        if FileManager.default.fileExists(atPath: self.fileURL.path) {
            print ("File exists")
            return true
        } else {
            print ("File does not exist")
            return false
        }
    }

    func createDirectory() throws {
        // create directory
        print ("Creating directory: \(self.fileURL)")
        do{
            try FileManager.default.createDirectory(at: self.fileURL, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError{
            print("Unable to create directory -- ", error)
            throw error
        }
    }

    func save(jsonString: String) throws {
        let documentsPath = FileManager.documentsDirectory()
        let fileURL = documentsPath.appendingPathComponent(self.fileName)

        print ("Saving -- \(fileURL)")

        do {
            //try str.write(to: , atomically: true, encoding: String.Encoding.utf8)
            try jsonString.write(to: fileURL, atomically: true, encoding: .utf8)
            print ("Did save file")
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            throw error
        }
    }

    func read() throws -> Data {
        //let filemgr = FileManager.default

        guard let data = try? Data(contentsOf: fileURL, options: [.mappedIfSafe]) else {
            throw FileError.couldNotLoadFile(fileURL.path)
        }
        return data
    }

    func removeFile() throws {
        let documentsPath = FileManager.documentsDirectory()
        let filemgr = FileManager.default
        let fileURL = documentsPath.appendingPathComponent(self.fileName)

        do {
            try filemgr.removeItem(at: fileURL)
            print("Removal successful")
        } catch let error {
            print("Error: \(error.localizedDescription)")
            throw error
        }
    }
}
