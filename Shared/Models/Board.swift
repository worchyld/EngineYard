//
//  Board.swift
//  EngineYard
//
//  Created by Amarjit on 29/05/2022.
//

import Foundation

class Board {
    public private(set) var locos: [Locomotive] = [Locomotive]()
    public private(set) var decks: [Deck] = [Deck]()
}

extension Board {
    func prepare() {

        self.locos = [
            //         id   ,   name                ,   £    color       gen         tp   maxDice
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
        ]
        
        var decks: [Deck] = [Deck]()
                    
        // Prepare cards & add to deck

        for loco in self.locos {
            var cards: [Card] = [Card]()
            
            for _ in 0...loco.trainPool {
                let c = Card.init(loco: loco)
                cards.append(c)
            }
            
            let deck = Deck.init(locomotive: loco, cards: cards)
            decks.append(deck)
        }
        
        self.decks = decks
    }
}

