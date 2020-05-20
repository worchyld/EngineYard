//
//  ListCardsProtocols.swift
//  EngineYard
//
//  Created by Amarjit on 20/05/2020.
//  Copyright © 2020 Amarjit. All rights reserved.
//

import Foundation
import UIKit

// Presenter -> View
protocol ListCardsPresenterToViewProtocol: class {
    func showCards(cardModel: CardResponseModel)
    func showError()
}

// Interactor -> Presenter
protocol ListCardsInteractorToPresenterProtocol: class {
    //func employeeListFeed(cardModel: CardResponseModel)
    //func employeeListFetchedFailed()
    func cardListFetchFeed(cardModel: CardResponseModel)
    func cardListFetchFailed()
}

// Presenter -> Interactor
protocol ListCardsPresentorToInteractorProtocol: class {
    var presenter: ListCardsInteractorToPresenterProtocol? {get set}
    func fetchCardList()
}

// -----

// View -> Presenter
protocol ListCardsViewToPresenterProtocol: class {
    var view: ListCardsPresenterToViewProtocol? {get set}
    var interactor: ListCardsPresentorToInteractorProtocol? {get set}
    var router: ListCardsPresenterToRouterProtocol? {get set}
    func showCardsList()
}

// Presenter -> Router
protocol ListCardsPresenterToRouterProtocol: class {
    static func start() -> UIViewController
}
