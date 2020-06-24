//
//  Factory+Filter.swift
//  EngineYard
//
//  Created by Amarjit on 24/06/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

extension Factory {

    public static func filter(factories: [Factory], on livery: Livery) throws -> [Factory] {
        factories
            .filter({$0.livery == livery})
            .sorted { (a: Factory, b: Factory) -> Bool in
                return (a.cost < b.cost) &&
                    (a.livery.rawValue < b.livery.rawValue) &&
                    (a.generation.rawValue < b.livery.rawValue)
        }
    }

}
