//
//  ListCardsInteractor.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation


// ListCards Interactor
class ListCardsInteractor: ListCardsPresentorToInteractorProtocol{
    var presenter: ListCardsInteractorToPresenterProtocol?

    func fetchCardList() {
        print ("Fetch card list")

        let sampleCardResponseModel = CardResponseModel.init(cards: [Card.init(cost: 4, color: .green, generation: .first)])

        self.presenter?.cardListFetchFeed(cardModel: sampleCardResponseModel)
    }
}
