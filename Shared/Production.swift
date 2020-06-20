//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 19/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

protocol ResetProductionDelegate {
    func reset(production: inout Production)
}

final class Production : Identifiable, SpendingDelegate, CreditDelegate {
    let id: UUID
    var units: Int
    internal var spent: Int = 0

    init(_ id: UUID = UUID(), units: Int = 0) {
        self.id = id
        self.units = units
    }
}




/*
extension Production {
    public static func builder(units: Int = 0) -> Production {
        return Production(units: units)
    }
}
*/
