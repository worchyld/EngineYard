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
            PhaseTwo()
            /*
            GreenState(),
            YellowState(),
            RedState()*/
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
}

class PhaseTwo : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PhaseTwo.Type
    }

    override func didEnter(from previousState: GKState?) {
        print("PhaseTwo")
    }
}


/*
class GreenState: GKState {

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is YellowState.Type
    }

    override func didEnter(from previousState: GKState?) {
        print("Traffic light is green")
    }
}

class YellowState: GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is RedState.Type
    }

    override func didEnter(from previousState: GKState?) {
        print("Traffic light is yellow")
    }

}

class RedState: GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GreenState.Type
    }

    override func didEnter(from previousState: GKState?) {
        print("Traffic light is red")
    }
}
*/
