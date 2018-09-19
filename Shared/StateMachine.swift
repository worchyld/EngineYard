//
//  StateMachine.swift
//  EngineYard
//
//  Created by Amarjit on 19/09/2018.
//  Copyright © 2018 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

class StateMachine : GKStateMachine {
    override init(states: [GKState]) {
        super.init(states: states)
    }

    public static func prepare() -> StateMachine {
        let states: [GKState] = [
            LocomotivePurchasePhase(),
            ProductionPurchasePhase(),
            SellingPhase(),
            TaxesPhase(),
            MarketDemandsPhase(),
            WinnerDeclaredPhase()
        ]
        return StateMachine.init(states: states)
    }
}

class LocomotivePurchasePhase : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is ProductionPurchasePhase.Type
    }

    override func didEnter(from previousState: GKState?) {
    }

    override func willExit(to nextState: GKState) {
    }
}

class ProductionPurchasePhase : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is SellingPhase.Type
    }

    override func didEnter(from previousState: GKState?) {
    }

    override func willExit(to nextState: GKState) {
    }
}

class SellingPhase : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is TaxesPhase.Type
    }

    override func didEnter(from previousState: GKState?) {
    }

    override func willExit(to nextState: GKState) {
    }
}

class TaxesPhase : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (
            (stateClass is MarketDemandsPhase.Type) ||
                (stateClass is WinnerDeclaredPhase.Type)
        )
    }

    override func didEnter(from previousState: GKState?) {
    }

    override func willExit(to nextState: GKState) {
    }
}

class MarketDemandsPhase : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is LocomotivePurchasePhase.Type
    }

    override func didEnter(from previousState: GKState?) {
    }

    override func willExit(to nextState: GKState) {
    }
}

class WinnerDeclaredPhase : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return false
    }

    override func didEnter(from previousState: GKState?) {
    }

    override func willExit(to nextState: GKState) {
    }
}


