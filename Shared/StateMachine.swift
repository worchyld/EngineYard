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
            PhaseOne()
            , PhaseTwo()
        ]
        //let machine = StateMachine.init(states: states)
        //machine.enter(PhaseOne.self)
        return StateMachine.init(states: states)
    }
}


// `BuyLocomotive` state
class PhaseOne : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (stateClass is PhaseTwo.Type)
    }

    override func didEnter(from previousState: GKState?) {
        let name = String(describing: PhaseOne.self)
        print ("Entered \(name) \(#function)")
    }

    override func willExit(to nextState: GKState) {
        print ("Exited \(#function)")
    }
}

// `BuyProduction` state
class PhaseTwo : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        //return (stateClass is PhaseTwo.Type)
        return false
    }

    override func didEnter(from previousState: GKState?) {
        let name = String(describing: PhaseTwo.self)
        print ("Entered \(name) \(#function)")
    }

    override func willExit(to nextState: GKState) {
        print ("Exited \(#function)")
    }
}


