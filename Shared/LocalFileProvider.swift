//
//  FileProvider.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias DataHandler = (Result<Data, Error>) -> Void
typealias GenericResultHandler<T> = (Result<T, Error>) -> Void


struct LocalFileProvider: RequestLocalFile {

    fileprivate let processFileQueue = DispatchQueue(label: "Process file queue", qos: DispatchQoS.background)

    // MARK: - Load local file

    fileprivate func loadLocalFile(from url: URL, completion: @escaping DataHandler ) {

        processFileQueue.async(execute: { () -> Void in
            do{
                let data = try Data(contentsOf: url, options: .mappedIfSafe)

                guard (data.count > 0) else {
                    let error = FileError.fileHasNoData
                    DispatchQueue.main.async { completion( Result.failure(error) )}
                    return
                }

                DispatchQueue.main.async { completion( Result.success(data) )}
            }
            catch {

                print("Could not load URL: \(url): \(error)")
                print (error.localizedDescription)

                DispatchQueue.main.async { completion( Result.failure(error) )}

            }
        })


    }
}

protocol RequestLocalFile { }

extension RequestLocalFile where Self == LocalFileProvider {

    func requestLocalFile(from url: URL, completion: @escaping DataHandler ) {

        self.loadLocalFile(from: url, completion: completion)

    }
}
