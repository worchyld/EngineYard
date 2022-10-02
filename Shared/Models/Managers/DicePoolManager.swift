//
//  DicePoolManager.swift
//  EngineYard
//
//  Created by Amarjit on 18/09/2022.
//

import Foundation
//
//public enum OrderType: Int {
//    case order, sale
//}
//
//public class Order {
//    var value: D6
//    var type: OrderType = .order
//    
//    init() {
//        self.value = D6.init()
//    }
//    
//    func decrement() {
//        self.value.decrement()
//    }
//    
//    func changeOrderType(_ toOrderType: OrderType = .order) {
//        self.type = toOrderType
//    }
//}
//
//class DicePoolManager {
//    private var deck: Deck
//    
//    init(deck: Deck) {
//        self.deck = deck
//    }
//    
//    func addToDicePool() throws {
//        guard try self.canAdd() else {
//            return
//        }
//        
//        self.deck.addToDicePool(d6: D6())
//    }
//    
//    private func canAdd() throws -> Bool {
//        guard (self.deck.dicePool.count < self.deck.maxDice) else {
//            throw DicePoolError.poolIsFull
//        }
//        return true
//    }
//    
//}
