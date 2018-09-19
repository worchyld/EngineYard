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
            PhaseOne(),
            PhaseTwo(),
            PhaseThree()
        ]
        return StateMachine.init(states: states)
    }
}

class PhaseOne : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PhaseTwo.Type
    }

    override func didEnter(from previousState: GKState?) {
        print("PhaseOne")
    }

    override func willExit(to nextState: GKState) {
        print ("Exiting to \(nextState)")
    }
}

class PhaseTwo : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PhaseThree.Type
    }

    override func didEnter(from previousState: GKState?) {
        print("PhaseTwo")
    }

    override func willExit(to nextState: GKState) {
        print ("Exiting to \(nextState)")
    }
}

class PhaseThree : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return false
    }

    override func didEnter(from previousState: GKState?) {
        print("PhaseThree")
    }

    override func willExit(to nextState: GKState) {
        print ("Exiting to \(nextState)")
    }
}
