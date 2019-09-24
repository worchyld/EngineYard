//
//  GameModel.swift
//  EngineYard
//
//  Created by Amarjit on 22/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

enum GamePhase: Int {
    case PurchaseLocomotivePhase
    case PurchaseProductionPhase
    case SellingPhase
    case PayTaxesPhase
    case MarketDemandsPhase
    case CheckEndGameTriggerPhase
    case DeclareWinnerPhase
}

class GameModel {

    func didTriggerEndGame(cash: Int) -> Bool {
        return (cash >= Constants.endGameCashTrigger)
    }

}
