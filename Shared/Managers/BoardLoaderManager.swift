//
//  BoardLoaderManager.swift
//  EngineYard
//
//  Created by Amarjit on 15/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

class BoardLoaderManager {
//    private lazy var queue: OperationQueue = {
//      var queue = OperationQueue()
//      queue.name = "Load PList from disk"
//      queue.maxConcurrentOperationCount = 1
//      return queue
//    }()
    //let queue = OperationQueue()
    //queue.name = "Load PList from disk"
    //queue.maxConcurrentOperationCount = 1
    //queue.waitUntilAllOperationsAreFinished()

    static func loadBoard(completionHandler: @escaping (Board?, Error?) -> Void) {
        print ("- loadBoard -")
        PListFileLoader.getDataFrom(filename: "data.plist") { (data, error) in
            if (error != nil) {
                print ("errors found")
                completionHandler(nil, error)
            }
            else {
                guard let hasData = data else {
                    print ("no data found")
                    completionHandler(nil, error)
                    return
                }
                do {
                    print ("found board")
                    let board = try decodeBoard(from: hasData)
                    completionHandler(board, nil)
                } catch {
                    print ("some other board error occured")
                    completionHandler(nil, error)
                }
            }
        }

        /*
        DispatchQueue.global(qos: .utility).async {
            PListFileLoader.getDataFrom(filename: "data.plist") { (data, error) in

                let data = try LoadPListTest().testImportPlistHasData()
                let decoder = PropertyListDecoder()
                let board = try decoder.decode(Board.self, from: data)


                DispatchQueue.main.async {

                if (error != nil) {

                        completionHandler(nil, error)
                    }
                } else {
                    DispatchQueue.main.async {
                        print (data as Any)
                    }
                }
            }
        }*/
    }

    private class func decodeBoard(from data: Data) throws -> Board {
        let decoder = PropertyListDecoder()
        do {
            let board = try decoder.decode(Board.self, from: data)
            return board
        }
        catch {
            throw error
        }

    }
}
