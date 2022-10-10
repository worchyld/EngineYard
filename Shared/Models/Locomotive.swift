//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 10/10/2022.
//

import Foundation

struct Locomotive: Codable, Identifiable {
    let id: String
    let name: String
    let color: Livery
    let generation: Generation
    let cost: Int
    var productionCost: Int {
        return Int(round(Double(self.cost) / 2))
    }
    var income: Int {
        return Int(round(Double(self.productionCost) / 2))
    }
    let qty: Int // how many exist
    let capacity: Int // for dice
    let rust: Rust
    var orders: [Int] = [Int]()
    var sales: [Int] = [Int]()
}

extension Locomotive {
    func allLocos() -> [Locomotive] {
        let locos: [Locomotive] = [
            Locomotive.init(id: UUID().uuidString, name: "General I", color: .green, generation: .first, cost: 4, qty: 4, capacity: 3, rust: .notBuilt),
            Locomotive.init(id: UUID().uuidString, name: "Fast Freight I", color: .red, generation: .first, cost: 8, qty: 4, capacity: 3, rust: .notBuilt),
            
            
            /*
            Locomotive(1    ,   "General I"         ,   4    , .green    , .first    , 4 , 3),
            Locomotive(2    ,   "Fast Freight"      ,   8    , .red      , .first    , 3 , 3),
            Locomotive(3    ,   "Heavy I"           ,   12   , .yellow   , .first    , 2 , 2),
            Locomotive(4    ,   "Special I"         ,   16   , .blue     , .first    , 1 , 1),
            Locomotive(5    ,   "General II"        ,   20   , .green    , .second   , 4 , 4),
            Locomotive(6    ,   "Fast Freight II"   ,   24   , .red      , .second   , 3 , 3),
            Locomotive(7    ,   "Heavy II"          ,   28   , .yellow   , .second   , 2 , 3),
            Locomotive(8    ,   "General III"       ,   32   , .green    , .third    , 4 , 4),
            Locomotive(9    ,   "Special II"        ,   36   , .blue     , .second   , 2 , 2),
            Locomotive(10   ,   "Fast Freight III"  ,   40   , .red      , .third    , 3 , 4),
            Locomotive(11   ,   "General IV"        ,   44   , .green    , .fourth   , 4 , 5),
            Locomotive(12   ,   "Heavy III"         ,   48   , .yellow   , .third    , 3 , 3),
            Locomotive(13   ,   "Fast Freight IV"   ,   52   , .red      , .fourth   , 4 , 4),
            Locomotive(14   ,   "General V"         ,   56   , .green    , .fifth    , 4 , 5),
             */
        ]
        return locos
    }
}
