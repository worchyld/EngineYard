//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

typealias Board = [Train?]

class TrainGame {
    var board: Board!

    public var countUnlocked : Int {
        return (self.board.compactMap({$0}).reduce(0) { $0 + ($1.available ? 1 : 0) })
    }


    func start(_ bundle: Bundle = Bundle.main) throws {
        do {
            self.board = try TrainGame.loadInitialBoard(bundle: bundle)
        }
        catch {
            throw error
        }
    }

    internal func unlockNextTrain(after train: Train) throws {
        guard let nextItem = self.board.after(train) else {
            return
        }
        guard let nextTrain = nextItem else {
            return
        }
        guard (nextTrain.available == false) else {
            return
        }
        let orderManager = OrderManager.init(train: nextTrain)
        try orderManager.addInitialOrder()
    }
}


extension TrainGame {
    public static func loadInitialBoard(bundle: Bundle) throws -> Board? {
        var board = [Train?](repeating: nil, count: 14)

        // Load JSON from Bundle
        let api = DataLoader.shared
        let result = api.load(from: bundle, file: Constants.boardJSONFile)

        switch result {
        case .success(let response):
            print ("RESPONSE RETURNED >> \(response)")

            guard let trains = response.trains else {
                throw NSError(domain: "Couldn't load the trains from data", code: 0, userInfo: nil)
            }

            for (index, train) in trains.enumerated() {
                board[index] = train
            }

            return board
        case .failure(let error):
            throw error
        }

        //return board
    }

}
