//
//  ObserverProtocols.swift
//  EngineYard
//
//  Created by Amarjit on 28/10/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

// Requires a list of observers and the ability to add, remove one and notify them
protocol ObservableProtocol : class {
    var observers : [ObserverProtocol] { get set }

    func addObserver(_ observer: ObserverProtocol)
    func removeObserver(_ observer: ObserverProtocol)
    func notifyObservers(_ observers: [ObserverProtocol])
}

// Need an observer capable of receiving a callback when the value changed
protocol ObserverProtocol {
    var id : Int { get set }
    func onValueChanged(_ value: Any?)
}
