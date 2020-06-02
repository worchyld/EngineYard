//
//  ListCardsPresenter.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation

//MARK: - ListCards Presenter
class ListCardsPresenter: ListCardsViewToPresenterProtocol {
    var view: ListCardsPresenterToViewProtocol?
    var interactor: ListCardsPresentorToInteractorProtocol?
    var router: ListCardsPresenterToRouterProtocol?

    func showCardsList() {
        interactor?.fetchCardList()
    }
}

//MARK: - Subscribing - ListCards Interactor
extension ListCardsPresenter: ListCardsInteractorToPresenterProtocol {
    func cardListFetchFeed(cardModel: CardResponseModel) {
        view?.showCards(cardModel: cardModel)
    }

    func cardListFetchFailed() {
        view?.showError()
    }
}
