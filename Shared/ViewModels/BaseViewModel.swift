//
//  BaseViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 17/11/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation

class BaseViewModel : CustomStringConvertible {
    weak var game: Game?

    lazy var playerOnTurn : Player? = {
        guard let hasGame = self.game else {
            return nil
        }
        guard let hasActivePlayer = hasGame.activePlayer else {
            return nil
        }
        return (hasActivePlayer as! Player)
    }()

    init(game: Game) {
        self.game = game

        guard let _ = self.game else {
            assertionFailure("ErrorCode.noGameObjectDefined")
            return
        }

        print (description)
    }
}

extension BaseViewModel {
    var description: String {
        guard let hasGame = self.game else {
            return "ErrorCode.noGameObjectDefined"
        }

        guard let hasGameBoard = hasGame.board else {
            return "ErrorCode.noGameBoardDefined"
        }

        return ("\(hasGame.description), decks: \(hasGameBoard.decks.count)")
    }
}


