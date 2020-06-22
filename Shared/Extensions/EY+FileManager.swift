//
//  EY+FileManager.swift
//  EngineYard
//
//  Created by Amarjit on 02/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// FileManager extensions

public enum FileManagerError : Error {
    case invalidPath( _ path: String)
    case invalidURL( _ url: URL)
    case fileNotFound( _ filename: String)
    case couldNotLoadFile(_ filename: String)
    case couldNotSaveFile(_ filename: String)
    case fileHasNoData
}

extension FileManager {
    class func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    class func cacheDirectory() -> URL {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        let firstPath = paths[0] as String
        return URL(fileURLWithPath: firstPath)
    }
}
