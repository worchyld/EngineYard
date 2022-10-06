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

        var locos = [
            //         id   ,   £    color       gen         tp   maxDice
            Locomotive(1    ,   4    , .green    , .first    , 4 , 3),
            Locomotive(2    ,   8    , .red      , .first    , 3 , 3),
            Locomotive(3    ,   12   , .yellow   , .first    , 2 , 2),
            Locomotive(4    ,   16   , .blue     , .first    , 1 , 1),
            Locomotive(5    ,   20   , .green    , .second   , 4 , 4),
            Locomotive(6    ,   24   , .red      , .second   , 3 , 3),
            Locomotive(7    ,   28   , .yellow   , .second   , 2 , 3),
            Locomotive(8    ,   32   , .green    , .third    , 4 , 4),
            Locomotive(9    ,   36   , .blue     , .second   , 2 , 2),
            Locomotive(10   ,   40   , .red      , .third    , 3 , 4),
            Locomotive(11   ,   44   , .green    , .fourth   , 4 , 5),
            Locomotive(12   ,   48   , .yellow   , .third    , 3 , 3),
            Locomotive(13   ,   52   , .red      , .fourth   , 4 , 4),
            Locomotive(14   ,   56   , .green    , .fifth    , 4 , 5),
        ]
        locos.sort(by: {
            $0.cost < $1.cost
        })
        self.locos = locos
        
        var decks: [Deck] = [Deck]()
                    
        // Prepare cards & add to deck
        for loco in locos {
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

