//
//  GameModel.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

class GameModel {

    func didTriggerEndGame(cash: Int) -> Bool {
        return (cash >= Constants.endGameCashTrigger)
    }

}
