//
//  EY+Paths.swift
//  EngineYardTests
//
//  Created by Amarjit on 15/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

// : FileManager extension

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
