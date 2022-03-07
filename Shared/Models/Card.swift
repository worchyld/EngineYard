//
//  Card.swift
//  EngineYard
//
//  Created by Amarjit on 20/11/2020.
//

import Foundation

protocol CardProtocol {
    var name: String { get }
    var image: String { get }
    var cost: Int { get }
    var livery: Livery { get set }
    var generation: Generation { get set }
    var rust: Rust { get set }
    var available: Bool { get set }
}


