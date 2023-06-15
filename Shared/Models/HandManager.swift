//
//  HandManager.swift
//  EngineYard
//
//  Created by Amarjit on 15/06/2023.
//

import Foundation

enum HandError: Error {
    case handIsEmpty
    case cardNotFound
    case alreadyOwnThisCard
}

extension HandError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .handIsEmpty:
            return NSLocalizedString("Hand is empty", comment: "Hand error: Hand is empty")
        case .cardNotFound:
            return NSLocalizedString("Card not found", comment: "Hand error: Card not found")
        case .alreadyOwnThisCard:
            return NSLocalizedString("Already own this card", comment: "Hand error: Already own this card")
        }
    }
}


class HandManager {
    private var player: Player

    init(player: Player) {
        self.player = player
    }
    
    var handSize: Int {
        get {
            return self.player.hand.count
        }
    }
    
    func add(card: Card) throws {
        
    }
    
    func remove(card: Card) throws {
        
    }
    
    func find(card: Card) throws -> Card? {
        let pile = self.player.hand
        guard pile.count > 0 else {
            throw HandError.handIsEmpty
        }
        
        let result = pile.filter { c in
            return c.id == card.id
        }.first
        
        return result
    }
    
    func checkHand(card: Card) throws {
        // check for duplicates        
    }
    
    
}
