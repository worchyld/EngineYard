//
//  AsyncOperation.swift
//  EngineYard
//
//  Created by Amarjit on 22/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

/* https://stackoverflow.com/questions/43561169/trying-to-understand-asynchronous-operation-subclass */

public class AsynchronousOperation: Operation {
    @objc private enum State: Int {
        case ready
        case executing
        case finished
    }

    private var _state = State.ready
    private let stateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".op.state", attributes: .concurrent)

    @objc private dynamic var state: State {
        get { return stateQueue.sync { _state } }
        set { stateQueue.sync(flags: .barrier) { _state = newValue } }
    }

    public override var isAsynchronous: Bool { return true }
    open override var isReady: Bool {
        return super.isReady && state == .ready
    }

    public override var isExecuting: Bool {
        return state == .executing
    }

    public override var isFinished: Bool {
        return state == .finished
    }

    open override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String> {
        if ["isReady",  "isFinished", "isExecuting"].contains(key) {
            return [#keyPath(state)]
        }
        return super.keyPathsForValuesAffectingValue(forKey: key)
    }

    public override func start() {
        if isCancelled {
            finish()
            return
        }
        self.state = .executing
        main()
    }
    open override func main() {
        fatalError("Implement in sublcass to perform task")
    }

    public final func finish() {
        if isExecuting {
            state = .finished
        }
    }
}
