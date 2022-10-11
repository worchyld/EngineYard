//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 10/10/2022.
//

import Foundation

struct Card: Identifiable {
    let id: UUID
    private let locomotive: Locomotive?
    let production: Production
    
    init(id: UUID, locomotive: Locomotive?) {
        self.id = UUID()
        self.locomotive = locomotive
        self.production = Production()
    }
}
