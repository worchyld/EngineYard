//
//  DataLoader.swift
//  EngineYardTests
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

struct DataLoader {

    public static func loadData(using bundle: Bundle, filename: String) -> Data? {
        DataLoader.debugInfo(bundle: bundle)

        if let url = bundle.url(forResource: filename, withExtension: nil) {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("error:\(error)")
            }
        }
        return nil
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
