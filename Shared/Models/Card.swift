//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 10/10/2022.
//

import Foundation

class Card: Identifiable, Codable {
    let id: UUID
    private let locomotive: Locomotive?
    public var loco: Locomotive? {
        return self.locomotive
    }
    public private (set) var production: Production
    
    init(id: UUID, locomotive: Locomotive?, production: Production = Production()) {
        self.id = UUID()
        self.locomotive = locomotive
        self.production = production
    }
    
    func changeProduction(_ production: Production) {
        self.production = production
    }
}

extension Card : Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}
