//
//  Deck.swift
//  EngineYard
//
//  Created by Amarjit on 19/09/2019.
//  Copyright © 2019 Amarjit. All rights reserved.
//

import Foundation

protocol DeckProtocol {
    var name : String { get  }
    var type : DeckType { get }
    var generation : Generation { get }

    var cost : Int { get }
    var productionCost : Int { get }
    var income : Int { get }

    var capacity : Int { get } // capacity for orders/customer base
    var numberOfChildren : Int { get }

    // Obsolescence
    var state : CardState { get set }
    var owners : Int { get }
}

final class Deck {

}
